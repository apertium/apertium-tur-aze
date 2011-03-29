sed 's/ /\n/g' |\
hfst-lookup -O apertium $TRMORPH 2> /dev/null |\
apertium-tagger -g tr-az.prob |\
lt-proc -b tr-az.autobil.bin
