rm -f scratch.sh
num_adv=`expr $2`
ls ../out/$1*.txt | awk '{ print "grep \"agent episode reward:\" "$0" | tail -1 | cut -f2 -d\"[\" | cut -f1 -d\"]\" | tr \",\" \"\n\" | head -'$num_adv'" }' > scratch_adv.sh
num_good=`expr $2 + 1`
ls ../out/$1*.txt | awk '{ print "grep \"agent episode reward:\" "$0" | tail -1 | cut -f2 -d\"[\" | cut -f1 -d\"]\" | tr \",\" \"\n\" | tail -n +'$num_good'" }' > scratch_good.sh
chmod +x scratch_good.sh
chmod +x scratch_adv.sh
./scratch_good.sh > scratch_good.txt
./scratch_adv.sh > scratch_adv.txt
#echo 'For adversary'
awk 'BEGIN{avg=0.0} { avg+=$0} END{print avg/NR}' scratch_adv.txt > x1
#echo 'For good'
awk 'BEGIN{avg=0.0} { avg+=$0} END{print avg/NR}' scratch_good.txt > x2
cat x1 x2 | tr '\n' ', '
rm -f scratch_good.txt
rm -f scratch_adv.txt
