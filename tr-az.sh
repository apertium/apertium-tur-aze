hfst-proc $TRMORPH |\
apertium-tagger -g tr-az.prob |\
apertium-transfer apertium-tr-az.tr-az.t1x tr-az.t1x.bin tr-az.autobil.bin

#lt-proc -b tr-az.autobil.bin
