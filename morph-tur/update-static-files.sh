TRMORPHDIR=$1

if [[ $TRMORPHDIR = "" ]]; then
	echo 'sh update-static-files.sh <trmorph dir>';
	exit;
fi


cp $1/lexicon/misc lexicon/misc
cp -r $1/phon/*.fst phon/
cp $1/phon/Makefile phon/
