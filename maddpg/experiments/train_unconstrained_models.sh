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
jbsub -interactive -cores 1+1 -q x86_6h -mem 100g /u/stamilse/miniconda3/bin/python train.py --scenario ${ENV_NAME} --num-agents ${AGENTS} --num-adversaries ${ADV} --u_estimation False  --constrained False --exp-name "MADDPG_${ENV_NAME}_${MODEL}_01" --save-dir ${work_dir} --plots-dir ${work_dir} > "${out_file}" 2> error
echo "Done."
echo ""
