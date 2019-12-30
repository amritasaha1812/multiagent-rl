rm -f scratch.sh
num_adv=`expr $2`
ls ../out/$1*.txt | awk '{ print "grep \"agent episode reward:\" "$0" | tail -1 | cut -f2 -d\"[\" | cut -f1 -d\"]\" | tr \",\" \"\n\" | head -1 | tail -1 " }' > scratch0.sh
ls ../out/$1*.txt | awk '{ print "grep \"agent episode reward:\" "$0" | tail -1 | cut -f2 -d\"[\" | cut -f1 -d\"]\" | tr \",\" \"\n\" | head -2 | tail -1 " }' > scratch1.sh
ls ../out/$1*.txt | awk '{ print "grep \"agent episode reward:\" "$0" | tail -1 | cut -f2 -d\"[\" | cut -f1 -d\"]\" | tr \",\" \"\n\" | head -3 | tail -1 " }' > scratch2.sh
ls ../out/$1*.txt | awk '{ print "grep \"agent episode reward:\" "$0" | tail -1 | cut -f2 -d\"[\" | cut -f1 -d\"]\" | tr \",\" \"\n\" | head -4 | tail -1 " }' > scratch3.sh
chmod +x *.sh
./scratch0.sh | sort -nr  | awk 'BEGIN{avg=0.0} { avg+=$0} END{print avg/NR}'> scratch0.txt
./scratch1.sh | sort -nr  | awk 'BEGIN{avg=0.0} { avg+=$0} END{print avg/NR}'> scratch1.txt
./scratch2.sh | sort -nr  | awk 'BEGIN{avg=0.0} { avg+=$0} END{print avg/NR}'> scratch2.txt
./scratch3.sh | sort -nr  | awk 'BEGIN{avg=0.0} { avg+=$0} END{print avg/NR}'> scratch3.txt
cat scratch0.txt scratch1.txt scratch2.txt scratch3.txt | head -$num_adv > scratch_adv.txt
num_good=`expr $2 + 1`
cat scratch0.txt scratch1.txt scratch2.txt scratch3.txt | tail -n +$num_good > scratch_good.txt
#echo 'For adversary'
awk 'BEGIN{avg=0.0} { avg+=$0} END{print avg/NR}' scratch_adv.txt > x1
#echo 'For good'
awk 'BEGIN{avg=0.0} { avg+=$0} END{print avg/NR}' scratch_good.txt > x2
cat x1 x2 | tr '\n' ', '
#rm -f scratch_good.txt
#rm -f scratch_adv.txt
#rm scratch*
