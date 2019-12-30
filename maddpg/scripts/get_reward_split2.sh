ls ../out/$1*.txt | awk '{ print "grep \"agent episode reward:\" "$0" | tail -1"} '  > scratch.sh
chmod +x scratch.sh
./scratch.sh | cut -f4- -d':' | sed 's/agent episode reward://g' | cut -f1 -d':' | sed 's/, time//g' | sed 's/^[ ]*//g' | sort -nr  
