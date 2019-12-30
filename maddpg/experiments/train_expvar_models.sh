MODEL="exp_var"
ENV_NAME="$1"
AGENTS=$2
ADV=$3           #Assuming number of adversaries <=2
GOOD=$(($AGENTS - $ADV))
mnum=${4:-""}
exp_var=15.0
out_file="models/${ENV_NAME}_policies${mnum}/02-non-linear-${MODEL}/out.txt"
work_dir="models/${ENV_NAME}_policies${mnum}/02-non-linear-${MODEL}/"
mkdir -p "models/${ENV_NAME}_policies${mnum}/02-non-linear-${MODEL}/"
echo "Running MADDPG_${ENV_NAME}_${MODEL}_02 with ${AGENTS} agents and ${ADV} adversaries..."
echo "Storing output in ${out_file}"
jbsub -interactive -cores 1+1 -q x86_6h -mem 100g /u/stamilse/miniconda3/bin/python train.py --scenario ${ENV_NAME} --num-agents ${AGENTS} --num-adversaries ${ADV} --u_estimation True  --constrained True --constraint_type "Exp_Var
" --exp_var_alpha ${exp_var} --exp-name "MADDPG_${ENV_NAME}_${MODEL}_02" --save-dir ${work_dir} --plots-dir ${work_dir} &> "${out_file}"
echo "Done."
echo "-------------------------------------------------------------------------------"
echo ""
