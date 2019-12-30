####jbsub -cores 1+1 -require k80 -mem 50g -err ../err/$2_$3_$4_uest_${10}_indep_$9_constr_True_expvar_$1.txt -out ../out/$2_$3_$4_uest_${10}_indep_$9_constr_True_expvar_$1.txt -q x86_6h /u/stamilse/miniconda3/bin/python3.6 train.py --scenario $2 --num-agents $3 --num-adversaries $4 --lr_actor $5 --lr_critic $6 --lr_lamda $7 --constrained True --constraint_type Exp_Var --exp_var_alpha $8 --independent-learner $9 --u_estimation ${10} --exp-name $2_$3_$4_uest_${10}_indep_$9_constr_True_expvar_$1

./run_expvar.sh $1 simple_push 2 1 0.005 0.01 0.0001 0.2390935 False False
./run_expvar.sh $1 simple_push 3 1 0.005 0.01 0.0001 0.058864 False False
./run_expvar.sh $1 simple_push 3 2 0.005 0.01 0.0001 0.03564715 False False
./run_expvar.sh $1 simple_push 4 2 0.005 0.01 0.0001 0.0623395 False False

./run_expvar.sh $1 simple_push 2 1 0.005 0.01 0.0001 0.3266 False True
./run_expvar.sh $1 simple_push 3 1 0.005 0.01 0.0001 0.599805 False True
./run_expvar.sh $1 simple_push 3 2 0.005 0.01 0.0001 0.374714 False True
./run_expvar.sh $1 simple_push 4 2 0.005 0.01 0.0001 0.69263 False True


./run_expvar.sh $1 simple_tag 2 1 0.005 0.01 0.0001 0.386654 False False
./run_expvar.sh $1 simple_tag 3 1 0.005 0.01 0.0001 0.2962265 False False
./run_expvar.sh $1 simple_tag 3 2 0.005 0.01 0.0001 2.67976 False False
./run_expvar.sh $1 simple_tag 4 2 0.005 0.01 0.0001 1.452025 False False

./run_expvar.sh $1 simple_tag 2 1 0.005 0.01 0.0001 4.66731 False True
./run_expvar.sh $1 simple_tag 3 1 0.005 0.01 0.0001 3.018165 False True
./run_expvar.sh $1 simple_tag 3 2 0.005 0.01 0.0001 23.5555 False True
./run_expvar.sh $1 simple_tag 4 2 0.005 0.01 0.0001 13.48625 False True


./run_expvar.sh $1 simple_adversary 2 1 0.005 0.01 0.0001 0.07659 False False
./run_expvar.sh $1 simple_adversary 3 1 0.005 0.01 0.0001 0.4722245 False False
./run_expvar.sh $1 simple_adversary 3 2 0.005 0.01 0.0001 0.754165 False False
./run_expvar.sh $1 simple_adversary 4 2 0.005 0.01 0.0001 1.45677 False False

./run_expvar.sh $1 simple_adversary 2 1 0.005 0.01 0.0001 0.433881 False True
./run_expvar.sh $1 simple_adversary 3 1 0.005 0.01 0.0001 0.098443 False True
./run_expvar.sh $1 simple_adversary 3 2 0.005 0.01 0.0001 0.539675 False True
./run_expvar.sh $1 simple_adversary 4 2 0.005 0.01 0.0001 0.2519075 False True
