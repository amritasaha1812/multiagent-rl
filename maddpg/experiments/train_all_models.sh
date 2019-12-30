#!/bin/#!/usr/bin/env bash

avg() { bc -l <<< "($1 + $2) / 2.0"; }
avg3() { bc -l <<< "($1 + $2 + $3) / 3.0"; }
max() { bc -l <<< "if ($1>$2) $1 else $2"; }
min() { bc -l <<< "if ($1<$2) $1 else $2"; }

echo ""
echo ""
echo "############### Automated Script to run all experiments for single environment ##########"
echo ""
echo ""

ENV_NAME="$1"
AGENTS=$2
ADV=$3           #Assuming number of adversaries <=2
GOOD=$(($AGENTS - $ADV))
mnum=${4:-""}

MODEL="uncons"
out_file="models/${ENV_NAME}_policies${mnum}/01-non-linear-${MODEL}/out.txt"
work_dir="models/${ENV_NAME}_policies${mnum}/01-non-linear-${MODEL}/"
mkdir -p "models/${ENV_NAME}_policies${mnum}/01-non-linear-${MODEL}/"
echo "Running MADDPG_${ENV_NAME}_${MODEL}_01 with ${AGENTS} agents and ${ADV} adversaries..."
echo "Storing output in ${out_file}"
python3 train.py --scenario ${ENV_NAME} --num-agents ${AGENTS} --num-adversaries ${ADV} --u_estimation False  --constrained False --exp-name "MADDPG_${ENV_NAME}_${MODEL}_01" --save-dir ${work_dir} --plots-dir ${work_dir} > "${out_file}" 2> error
echo "Done."
echo ""

LINE_1=$((AGENTS + 3))

exp_var="$(tail -${LINE_1} ${out_file}  | head -1 | cut -d ',' -f3 | sed 's/^.*: //')"
exp_var="$(echo $exp_var*0.5 | bc -l)"

cvar_adv="$(tail -$((LINE_1 - 1)) ${out_file}  | head -1 | cut -d ',' -f5 | sed 's/^.*: //')"
cvar_good="$(tail -3 ${out_file}  | head -1 | cut -d ',' -f5 | sed 's/^.*: //')"

if [ $AGENTS -ge 3 ]
then
  if [ $GOOD -eq 1 ]
  then
    cvar_adv2="$(tail -$((LINE_1 - 2)) ${out_file}  | head -1 | cut -d ',' -f5 | sed 's/^.*: //')"
    echo "$cvar_adv $cvar_adv2"
    cvar_adv=$(avg $cvar_adv $cvar_adv2)
  elif [ $GOOD -eq 3 ]
  then
    cvar_good2="$(tail -4 ${out_file}  | head -1 | cut -d ',' -f5 | sed 's/^.*: //')"
    cvar_good3="$(tail -5 ${out_file}  | head -1 | cut -d ',' -f5 | sed 's/^.*: //')"
    echo "cvar_good $cvar_good2 $cvar_good3"
    cvar_good=$(avg3 $cvar_good $cvar_good2 $cvar_good3)
  else
    cvar_good2="$(tail -4 ${out_file}  | head -1 | cut -d ',' -f5 | sed 's/^.*: //')"
    echo "$cvar_good $cvar_good2"
    cvar_good=$(avg $cvar_good $cvar_good2)
  fi
fi

if [ $AGENTS -eq 4 ]
then
  if [ $GOOD -eq 4 ]
  then
    cvar_good3="$(tail -5 ${out_file}  | head -1 | cut -d ',' -f5 | sed 's/^.*: //')"
    cvar_good4="$(tail -6 ${out_file}  | head -1 | cut -d ',' -f5 | sed 's/^.*: //')"
    cvar_good2=$(avg $cvar_good3 $cvar_good4)
    echo "$cvar_good $cvar_good2"
    cvar_good=$(avg $cvar_good $cvar_good2)
    cvar_adv=0.0
  else
    cvar_adv2="$(tail -$((LINE_1 - 2)) ${out_file}  | head -1 | cut -d ',' -f5 | sed 's/^.*: //')"
    echo "$cvar_adv $cvar_adv2"
    cvar_adv=$(avg $cvar_adv $cvar_adv2)
  fi
fi

if [ $ADV -eq 0 ]
then
  cvar_adv=0.0
fi

echo "$cvar_adv $cvar_good"

if (( $(echo "${cvar_adv} > 0" |bc -l) ))
then
  cvar_adv="$(echo $cvar_adv*2.0 | bc)"
else
  cvar_adv="$(echo $cvar_adv*0.5 | bc)"
fi

if (( $(echo "${cvar_good} > 0" |bc -l) ))
then
  cvar_good="$(echo $cvar_good*2.0 | bc)"
else
  cvar_good="$(echo $cvar_good*0.5 | bc)"
fi

echo "CVAR constraints: ${cvar_adv}, ${cvar_good}. EXP_VAR constraints: ${exp_var}"
echo "-------------------------------------------------------------------------------"
echo ""

###################################################################################################################

MODEL="cvar"
out_file="models/${ENV_NAME}_policies${mnum}/01-non-linear-${MODEL}/out.txt"
work_dir="models/${ENV_NAME}_policies${mnum}/01-non-linear-${MODEL}/"
mkdir -p "models/${ENV_NAME}_policies${mnum}/01-non-linear-${MODEL}/"
echo "Running MADDPG_${ENV_NAME}_${MODEL}_01 with ${AGENTS} agents and ${ADV} adversaries..."
echo "Storing output in ${out_file}"
python3 train.py --scenario ${ENV_NAME} --num-agents ${AGENTS} --num-adversaries ${ADV} --u_estimation False  --constrained True --constraint_type "CVAR" --cvar_alpha_adv_agent ${cvar_adv} --cvar_alpha_good_agent ${cvar_good} --exp-name "MADDPG_${ENV_NAME}_${MODEL}_01" --save-dir ${work_dir} --plots-dir ${work_dir} &> "${out_file}"
echo "Done."
echo "-------------------------------------------------------------------------------"
echo ""

out_file="models/${ENV_NAME}_policies${mnum}/02-non-linear-${MODEL}/out.txt"
work_dir="models/${ENV_NAME}_policies${mnum}/02-non-linear-${MODEL}/"
mkdir -p "models/${ENV_NAME}_policies${mnum}/02-non-linear-${MODEL}/"
echo "Running MADDPG_${ENV_NAME}_${MODEL}_02 with ${AGENTS} agents and ${ADV} adversaries..."
echo "Storing output in ${out_file}"
python3 train.py --scenario ${ENV_NAME} --num-agents ${AGENTS} --num-adversaries ${ADV} --u_estimation True  --constrained True --constraint_type "CVAR" --cvar_alpha_adv_agent ${cvar_adv} --cvar_alpha_good_agent ${cvar_good} --exp-name "MADDPG_${ENV_NAME}_${MODEL}_02" --save-dir ${work_dir} --plots-dir ${work_dir} &> "${out_file}"
echo "Done."
echo "-------------------------------------------------------------------------------"
echo ""

####################################################################################################################

MODEL="exp_var"

out_file="models/${ENV_NAME}_policies${mnum}/02-non-linear-${MODEL}/out.txt"
work_dir="models/${ENV_NAME}_policies${mnum}/02-non-linear-${MODEL}/"
mkdir -p "models/${ENV_NAME}_policies${mnum}/02-non-linear-${MODEL}/"
echo "Running MADDPG_${ENV_NAME}_${MODEL}_02 with ${AGENTS} agents and ${ADV} adversaries..."
echo "Storing output in ${out_file}"
python3 train.py --scenario ${ENV_NAME} --num-agents ${AGENTS} --num-adversaries ${ADV} --u_estimation True  --constrained True --constraint_type "Exp_Var" --exp_var_alpha ${exp_var} --exp-name "MADDPG_${ENV_NAME}_${MODEL}_02" --save-dir ${work_dir} --plots-dir ${work_dir} &> "${out_file}"
echo "Done."
echo "-------------------------------------------------------------------------------"
echo ""

out_file="models/${ENV_NAME}_policies${mnum}/01-non-linear-${MODEL}/out.txt"
work_dir="models/${ENV_NAME}_policies${mnum}/01-non-linear-${MODEL}/"
mkdir -p "models/${ENV_NAME}_policies${mnum}/01-non-linear-${MODEL}/"
echo "Running MADDPG_${ENV_NAME}_${MODEL}_01 with ${AGENTS} agents and ${ADV} adversaries..."
echo "Storing output in ${out_file}"
python3 train.py --scenario ${ENV_NAME} --num-agents ${AGENTS} --num-adversaries ${ADV} --u_estimation False  --constrained True --constraint_type "Exp_Var" --exp_var_alpha ${exp_var} --exp-name "MADDPG_${ENV_NAME}_${MODEL}_01" --save-dir ${work_dir} --plots-dir ${work_dir} &> "${out_file}"
echo "Done."
echo "-------------------------------------------------------------------------------"
echo ""
