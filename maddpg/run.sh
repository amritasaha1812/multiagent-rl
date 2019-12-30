jbsub -cores 1+1 -require k80 -mem 50g -err err/$1_$2_$3_$4.txt -out out/$1_$2_$3_$4.txt -q x86_1h python3 experiments/$1.py --scenario $2 --num-adversaries $3 $4
