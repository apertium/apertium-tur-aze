INFILE=$1 # This is one of the pending_ files
CORPUS=$2 # This is the corpus you're testing on

# Read through the pending_ file, line by line
#
# Example file:
#   2607 ^@bas<n>$
#   1857 ^@beta<n>$
#   1519 ^@dan<n>$
#   1285 ^@tur<n>$

cat $CORPUS | apertium -d ../../ tr-az-morph | apertium-tagger -p -g ../../tr-az.prob > /tmp/tr-az.crp.tagged;
for i in `cat $INFILE | sed 's/^ *//g' | sed 's/ /:/g' | cut -f1 -d'$'  | sed 's/ /_/g'`; do 
	# Pull out variables
	FREQ=`echo $i | cut -f1 -d':'`;
	POS=`echo $i | cut -f2 -d':' | cut -f2 -d'@' | cut -f2- -d'<' | sed 's/^/</g' | sed 's/<[0-9A-Za-z]\+>/<s n="&"\/>/g' | sed 's/>\?"<\?/"/g'`;
	LEMAPOS=`echo $i | cut -f2 -d'@' | cut -f1 -d'$'`; 
	LEMA=`echo $i | cut -f2 -d'@' | cut -f1 -d'<'`; 

	# strip the part of speech, e.g. <n> and convert to apertium tags, e.g. <s n="n"/>
	echo -n $FREQ" "$LEMAPOS": "; 
	# run the corpus through the tagger, grep out the first line with the word we're looking for
	# and put it in >> <<
	cat /tmp/tr-az.crp.tagged | grep "\/$LEMAPOS" | head -1 | sed "s/\/$LEMAPOS/<<\/$LEMAPOS/g" | python /home/fran/scripts/untag-corpus.py | sed 's/[A-Za-zışçğ0-9]\+<</ >>&/g' | sed 's/  / /g' | fold -s; 
	# print out the candidate bidix line
	echo "" ; 
	echo '    <e><p><l>'$LEMA''$POS'</l><r>@'$POS'</r></p></e>'; 
	echo "" ; 
	echo "================================================================================";
done
