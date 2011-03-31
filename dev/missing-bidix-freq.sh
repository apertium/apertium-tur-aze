INPUT=/tmp/tr-az.gentest.transfer
DEV=/home/fran/source/apertium/incubator/apertium-tr-az/dev/bidix/

echo "SECTION

SELECT (inf);" > /tmp/temp_cg ;

cg-comp /tmp/temp_cg /tmp/temp_cg.bin ;

cat $INPUT | grep '<v>' | grep '@' | cut -f2 -d'@' | cut -f1 -d'<' | lt-proc -w $DEV/../../tr-az.automorf.bin  | cg-proc /tmp/temp_cg.bin  | cut -f2- -d'/' | sed 's/<pres><p3><sg>//g' | grep '<vblex>' | cut -f1 -d'$' | sort -f | uniq -c | sort -gr  | grep -v '[0-9] $' > $DEV/pending_verbs.txt

cat $INPUT | grep '@' | grep '<adv>' | grep -v '<v' | sh ~/scripts/lowercase.sh  | sort -f | sed 's/^\W*\^/^/g' | sort -f | uniq -c | sort -gr  | grep -v '[0-9] $' > $DEV/pending_adverbs.txt

cat $INPUT | grep '@' | grep '<post' | grep -v '<v' | sh ~/scripts/lowercase.sh  | sort -f | sed 's/^\W*\^/^/g' | sort -f | uniq -c | sort -gr  | grep -v '[0-9] $'  > $DEV/pending_postpositions.txt

cat $INPUT | grep '@' | grep '<adj>'  | sed 's/<attr>//g' | sed 's/<pred>//g' | sh ~/scripts/lowercase.sh  | sed 's/[ανρχί]/\n/g' | sed 's/^\W*\^/^/g' | sort -f | uniq -c  | sort -gr  | grep -v '[0-9] $' | grep '<adj>' | grep '@' > $DEV/pending_adjectives.txt

cat $INPUT | grep '@' | grep '<n>'  | sed 's/\(<sg>\|<ins>\|<acc>\|<dat>\|<loc>\|<gen>\|<nom>\|<abs>\|<p1s>\|<p2s>\|<p3s>\|<p1p>\|<p2p>\|<p3p\)//g' | sed 's/<pl>//g' | sh ~/scripts/lowercase.sh  | sed 's/^\W*\^/^/g' | sort -f | uniq -c  | sort -gr  | grep -v '[0-9] $'  > $DEV/pending_nouns.txt

cat $INPUT | grep '@' | grep '<prn>'  | sed 's/\(<sg>\|<ins>\|<acc>\|<dat>\|<loc>\|<gen>\|<nom>\|<abs>\|<p1s>\|<p2s>\|<p3s>\|<p1p>\|<p2p>\|<p3p\)//g' | sed 's/<pl>//g' | sh ~/scripts/lowercase.sh  | sed 's/^\W*\^/^/g' | sort -f | uniq -c  | sort -gr  | grep -v '[0-9] $'  > $DEV/pending_pronouns.txt

cat $INPUT | grep '@' | grep '<num>'  | sed 's/<sg>//g' | sed 's/<pl>//g' | sh ~/scripts/lowercase.sh  | sed 's/^\W*\^/^/g' | sort -f | uniq -c  | sort -gr  | grep -v '[0-9] $' > $DEV/pending_numerals.txt

cat $INPUT | grep '@' | grep '<np>'  | sed 's/<sg>//g' | sed 's/<pl>//g' | sed 's/^\W*\^/^/g' | sort -f | uniq -c  | sort -gr  | grep -v '[0-9] $' > $DEV/pending_proper_nouns.txt

cat $INPUT | grep '@' | grep '<cnj'  | sed 's/<sg>//g' | sed 's/<pl>//g' | sh ~/scripts/lowercase.sh | sed 's/^\W*\^/^/g' | sort -f | uniq -c  | sort -gr  | grep -v '[0-9] $' > $DEV/pending_conjunctions.txt

cat $INPUT | grep '@' | grep '<det>'  | sed 's/<sg>//g' | sed 's/<pl>//g' | sed 's/^\W*\^/^/g' | sort -f | uniq -c  | sort -gr  | grep -v '[0-9] $' > $DEV/pending_determiners.txt

cat bilingual-summary.txt

echo ""

wc -l $DEV/pending_* | sort -gr  > bilingual-summary.txt

cat bilingual-summary.txt
