####jbsub -cores 1+1 -require k80 -mem 50g -err ../err/$2_$3_$4_uest_${11}_indep_${10}_constr_True_expvar_$1.txt -out ../out/$2_$3_$4_uest_${11}_indep_${10}_constr_True_expvar_$1.txt -q x86_6h /u/stamilse/miniconda3/bin/python3.6 train.py --scenario $2 --num-agents $3 --num-adversaries $4 --lr_actor $5 --lr_critic $6 --lr_lamda $7 --constrained True --constraint_type CVAR --cvar_alpha_adv_agent $8 --cvar_alpha_good_agent $9 --independent-learner ${10} --u_estimation ${11} --exp-name $2_$3_$4_uest_${11}_indep_${10}_constr_True_cvar_$1

./run_cvar.sh $1 simple_push 2 1 0.005 0.01 0.0001 5.01208 -0.1411405 False False
./run_cvar.sh $1 simple_push 3 1 0.005 0.01 0.0001 1.072876 -0.231652 False False
./run_cvar.sh $1 simple_push 3 2 0.005 0.01 0.0001 4.99136 -0.2160695 False False
./run_cvar.sh $1 simple_push 4 2 0.005 0.01 0.0001 0.937244 -0.3230785 False False

./run_cvar.sh $1 simple_push 2 1 0.005 0.01 0.0001 5.1417 -0.141948 False True
./run_cvar.sh $1 simple_push 3 1 0.005 0.01 0.0001 1.170458 -0.241989 False True
./run_cvar.sh $1 simple_push 3 2 0.005 0.01 0.0001 5.02364 -0.2054995 False True
./run_cvar.sh $1 simple_push 4 2 0.005 0.01 0.0001 1.34819 -0.2951025 False True


./run_cvar.sh $1 simple_tag 2 1 0.005 0.01 0.0001 7.8951 -0.135852 False False
./run_cvar.sh $1 simple_tag 3 1 0.005 0.01 0.0001 7.354 0.630122 False False
./run_cvar.sh $1 simple_tag 3 2 0.005 0.01 0.0001 29.8772 -0.669975 False False
./run_cvar.sh $1 simple_tag 4 2 0.005 0.01 0.0001 27.5676 0.371744 False False

./run_cvar.sh $1 simple_tag 2 1 0.005 0.01 0.0001 7.58554 -0.132599 False True
./run_cvar.sh $1 simple_tag 3 1 0.005 0.01 0.0001 7.69806 0.298884 False True
./run_cvar.sh $1 simple_tag 3 2 0.005 0.01 0.0001 30.9574 -0.827925 False True
./run_cvar.sh $1 simple_tag 4 2 0.005 0.01 0.0001 27.5548 -0.0272559 False True


./run_cvar.sh $1 simple_adversary 2 1 0.005 0.01 0.0001 -0.202956 14.91736 False False
./run_cvar.sh $1 simple_adversary 3 1 0.005 0.01 0.0001 -0.640655 32.114 False False
./run_cvar.sh $1 simple_adversary 3 2 0.005 0.01 0.0001 -0.2766445 44.0876 False False
./run_cvar.sh $1 simple_adversary 4 2 0.005 0.01 0.0001 -1.176065 63.18 False False

./run_cvar.sh $1 simple_adversary 2 1 0.005 0.01 0.0001 -0.175085 14.98018 False True
./run_cvar.sh $1 simple_adversary 3 1 0.005 0.01 0.0001 -0.56986 32.1294 False True
./run_cvar.sh $1 simple_adversary 3 2 0.005 0.01 0.0001 -0.2491265 44.5418 False True
./run_cvar.sh $1 simple_adversary 4 2 0.005 0.01 0.0001 -1.030415 65.21 False True

