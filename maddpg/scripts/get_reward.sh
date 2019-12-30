rm -f scratch.sh
ls ../out/$1*.txt | awk '{ print "grep \"mean episode reward:\" "$0" | tail -1"}' >> scratch.sh
chmod +x scratch.sh
./scratch.sh >> scratch.txt
grep 'mean episode reward: [0-9\.e\-]*,' -o scratch.txt | cut -f4 -d' ' | sort -nr | head -5 | awk 'BEGIN{avg=0.0} {avg+=$0} END{ print avg/NR}' 
rm -f scratch.sh
rm -f scratch.txt
