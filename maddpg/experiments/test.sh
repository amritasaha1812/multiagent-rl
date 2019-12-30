#!/bin/#!/usr/bin/env bash

ENV_NAME=$1 # scenario name
AGENTS=$2   # no. of agents
ADV=$3      # no. of adversaries
U1=$4       # =1 if u_estimation=False for Exp-Var, else 2
U2=$5       # =1 if u_estimation=False for CVAR, else 2
model=${6:-""}  # only if not using default model

if [ $U1 -eq 1 ]
then
  uest1="False"
else
  uest1="True"
fi

if [ $U2 -eq 1 ]
then
  uest2="False"
else
  uest2="True"
fi

MODEL="uncons"
work_dir="models/${ENV_NAME}_policies${model}/01-non-linear-${MODEL}/"
python3 train.py --test --scenario ${ENV_NAME} --num-agents ${AGENTS} --num-adversaries ${ADV} --u_estimation False  --constrained False --exp-name "MADDPG_${ENV_NAME}_${MODEL}_01" --save-dir ${work_dir} --restore --display

MODEL="exp_var"
work_dir="models/${ENV_NAME}_policies${model}/0${U1}-non-linear-${MODEL}/"
sed -i '' 's/def reset_world(self, world, load = False):/def reset_world(self, world, load = True):/g' "../../multiagent-particle-envs/multiagent/scenarios/${ENV_NAME}.py"
python3 train.py --test --scenario ${ENV_NAME}  --num-agents ${AGENTS} --num-adversaries ${ADV} --u_estimation ${uest1}  --constrained True --constraint_type "Exp_Var" --exp-name "MADDPG_${ENV_NAME}_${MODEL}_01" --save-dir ${work_dir} --restore --display

MODEL="cvar"
work_dir="models/${ENV_NAME}_policies${model}/0${U2}-non-linear-${MODEL}/"
python3 train.py --test --scenario ${ENV_NAME} --num-agents ${AGENTS} --num-adversaries ${ADV} --u_estimation ${uest2}  --constrained True --constraint_type "CVAR" --exp-name "MADDPG_${ENV_NAME}_${MODEL}_01" --save-dir ${work_dir} --restore --display
sed -i '' 's/def reset_world(self, world, load = True):/def reset_world(self, world, load = False):/g' "../../multiagent-particle-envs/multiagent/scenarios/${ENV_NAME}.py"

#simple_push 2 2
#simple_spread 1 1
#simple_adversary 1 2
#simple_tag 1 2
