#!/bin/bash

DEV=$(dirname $0)
TMP=/tmp
ALPHABET="ABĊDEFĠGGHĦIIJKLMNOPQRSTUVWXZŻabċdefġgħghieiejklmnopqrstuvwxzżycYCáéíóúàèìòùşçğäëïöü"
# alphabet of LANG1 (not LANG2), used to ignore punctuation, regexes etc.

PREFIX=$1
BASENAME=apertium-$PREFIX

CORPUS=$2
transfer () {
    apertium-pretransfer | apertium-transfer ${DEV}/../${BASENAME}.${PREFIX}.t1x  ${DEV}/../${PREFIX}.t1x.bin  ${DEV}/../${PREFIX}.autobil.bin;
}
GENBIN=${DEV}/../${PREFIX}.autogen.hfst

# Find all forms and analyses of the source dictionary:
cat $CORPUS | apertium-destxt | hfst-proc -w ../${PREFIX}.automorf.hfst | cg-proc ../${PREFIX}.rlx.bin | apertium-tagger -g ../${PREFIX}.prob | sed 's/\$\W*\^/$\n^/g' |\
        # Print analysis, but only of lines like "form:lemma<tag>" or "form:>:lemma<tag>" (characters 'm' and 'l' are in $ALPHABET)
        # turning analysis into the format ^lemma<tag>$
        sed 's/$/^.<pnct>$/g' |\
                              tee $TMP/${PREFIX}_testvoc1 |\
        transfer            | tee $TMP/${PREFIX}_testvoc2 |\
        hfst-proc -d $GENBIN  >     $TMP/${PREFIX}_testvoc3

# Output:
paste $TMP/${PREFIX}_testvoc1 $TMP/${PREFIX}_testvoc2 $TMP/${PREFIX}_testvoc3 |\
        sed 's/\^.<pnct>\$//g' | sed 's/\t/   --------->  /g' | sed 's/\\//g' | sed 's/ \.$//' | grep -v '\*' | sort -f | uniq -c | sort -gr

# Remove temp files:
#rm -f $TMP/${PREFIX}_testvoc1 $TMP/${PREFIX}_testvoc2 $TMP/${PREFIX}_testvoc3
