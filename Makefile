all:
	apertium-validate-dictionary apertium-tr-az.tr-az.dix
	lt-comp lr apertium-tr-az.tr-az.dix tr-az.autobil.bin

	apertium-validate-transfer apertium-tr-az.tr-az.t1x
	apertium-preprocess-transfer apertium-tr-az.tr-az.t1x tr-az.t1x.bin
	
	cg-comp apertium-tr-az.tr-az.rlx tr-az.rlx.bin

	apertium-gen-modes modes.xml
	cp *.mode modes/
