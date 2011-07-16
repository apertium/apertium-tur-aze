INFILE=$1 # This is one of the pending_ files
CORPUS=$2 # This is the corpus you're testing on

# Read through the pending_ file, line by line
for i in `cat $INFILE | cut -f2 -d'@' | cut -f1 -d'$'  | sed 's/ /_/g'`; do 
	# strip the part of speech, e.g. <n> and convert to apertium tags, e.g. <s n="n"/>
	POS=`echo $i | cut -f2- -d'<' | sed 's/^/</g' | sed 's/<[0-9A-Za-z]\+>/<s n="&"\/>/g' | sed 's/>\?"<\?/"/g'`;
	echo -n $i": "; 
	# run the corpus through the tagger, grep out the first line with the word we're looking for
	# and put it in >> <<
	cat $CORPUS | apertium -d ../../ tr-az-morph | apertium-tagger -p -g ../../tr-az.prob | grep "\/$i" | head -1 | sed "s/\/$i/<<\/$i/g" | python /home/fran/scripts/untag-corpus.py | sed 's/[A-Za-zışçğ0-9]\+<</ >>&/g'; 
	# print out the candidate bidix line
	echo "" ; 
	echo '    <e><p><l>'`echo $i | cut -f1 -d'<'`$POS'</l><r>@'$POS'</r></p></e>'; 
	echo "======================================================================="; 
done
