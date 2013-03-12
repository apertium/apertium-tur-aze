VERSION=0.2.0
LANG1=tr
LANG2=az
PREFIX1=$(LANG1)-$(LANG2)
PREFIX2=$(LANG2)-$(LANG1)

BASENAME=apertium-$(PREFIX1)

SUBDIRS=phon

FSTNAME=trmorph

TARGETS = $(PREFIX2).autogen.hfst $(PREFIX1).automorf.hfst

$(PREFIX1).automorf.hfst: $(FSTNAME).a
	hfst-invert -i $< | hfst-fst2fst -O -o $@
	cp $@ ../

$(PREFIX2).autogen.hfst: $(FSTNAME).a
	hfst-fst2fst -O -i $< -o $@
	cp $@ ../

$(FSTNAME).a: version.a num.a deriv.a $(FSTNAME).fst
	hfst-calculate -w -v -i $(FSTNAME).fst -o $@

num.a: num.fst
	hfst-calculate -w -v -i num.fst -o num.a

version.a: version.fst
	hfst-calculate -w -v -i version.fst -o version.a

deriv.a: deriv.fst
	hfst-calculate -w -v -i deriv.fst -o deriv.a

apertium_tr_azdir=$(prefix)/share/apertium/apertium-$(PREFIX1)/
apertium_tr_az_DATA=$(PREFIX2).autogen.hfst $(PREFIX1).automorf.hfst 


CLEANFILES = *.a $(TARGETS)
