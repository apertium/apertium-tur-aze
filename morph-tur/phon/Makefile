FSTFILES = 010-exception_deye.fst 020-compn.fst \
		   040-exception_ben.fst 050-exception_su.fst 060-xception_del_bS.fst\
		   070-exception_del_buff.fst 080-vowel_epenth.fst 090-duplication.fst\
		   100-fs_devoicing.fst 110-v_assimilation.fst 120-passive_ln.fst\
		   130-exception_yor.fst 140-v_harmony.fst 015-exception_obs.fst\
		   017-exception_i.fst 
FSAFILES=$(FSTFILES:.fst=.a)
SOURCES = $(LEXFILES) $(FSTFILES)

.PHONY: all install

%.a: %.fst
	hfst-calculate -w -v -i $< -o $@	



all: phon.a

phon.a: $(FSAFILES) phon.fst ../symbols.fst

clean:
	-rm -f *.a *~ Makefile.bak 

#Makefile: *.fst
#	-makedepend -Y -o.a $(SOURCES) 2>/dev/null 

# DO NOT DELETE

010-exception_deye.a: ../symbols.fst
015-exception_obs.a: ../symbols.fst
017-exception_i.a: ../symbols.fst
020-compn.a: ../symbols.fst
040-exception_ben.a: ../symbols.fst
050-exception_su.a: ../symbols.fst
060-xception_del_bS.a: ../symbols.fst
070-exception_del_buff.a: ../symbols.fst
080-vowel_epenth.a: ../symbols.fst
090-duplication.a: ../symbols.fst
100-fs_devoicing.a: ../symbols.fst
110-v_assimilation.a: ../symbols.fst
120-passive_ln.a: ../symbols.fst
130-exception_yor.a: ../symbols.fst
140-v_harmony.a: ../symbols.fst
phon.a: ../symbols.fst
