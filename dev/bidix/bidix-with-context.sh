INFILE=$1
CORPUS=$2

for i in `cat $INFILE | cut -f2 -d'@' | cut -f1 -d'$'  | sed 's/ /_/g'`; do 
	POS=`echo $i | cut -f2- -d'<' | sed 's/^/</g' | sed 's/<[0-9A-Za-z]\+>/<s n="&"\/>/g' | sed 's/>\?"<\?/"/g'`;
	echo -n $i": "; 
	cat $CORPUS | apertium -d ../../ tr-az-morph | apertium-tagger -p -g ../../tr-az.prob | grep "\/$i" | head -1 | sed "s/\/$i/<<\/$i/g" | python /home/fran/scripts/untag-corpus.py | sed 's/[A-Za-zışçğ0-9]\+<</ >>&/g'; 
	echo "" ; 
	echo '    <e><p><l>'`echo $i | cut -f1 -d'<'`$POS'</l><r>@'$POS'</r></p></e>'; 
	echo "======================================================================="; 
done
