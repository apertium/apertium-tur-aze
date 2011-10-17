###############################################################################
## Makefile for Turkish--Azerbaijani
###############################################################################

VERSION=0.2.0
LANG1=tr
LANG2=az
PREFIX1=$(LANG1)-$(LANG2)
PREFIX2=$(LANG2)-$(LANG1)

BASENAME=apertium-$(PREFIX1)

SUBDIRS = . morph-tr morph-az

TARGETS_COMMON = $(PREFIX1).autobil.bin $(PREFIX2).autobil.bin  \
	$(PREFIX1).t1x.bin $(PREFIX1).rlx.bin \
	$(PREFIX1).mode modes 

###############################################################################
## Bilingual dictionaries
###############################################################################

.deps/$(BASENAME).$(PREFIX1).dix: $(BASENAME).$(PREFIX1).dix lexchoicebil.xsl
	if [ ! -d .deps ]; then mkdir .deps; fi
	xsltproc lexchoicebil.xsl $(BASENAME).$(PREFIX1).dix > $@

$(PREFIX1).autobil.bin: .deps/$(BASENAME).$(PREFIX1).dix
	apertium-validate-dictionary .deps/$(BASENAME).$(PREFIX1).dix
	lt-comp lr .deps/$(BASENAME).$(PREFIX1).dix $@

$(PREFIX2).autobil.bin: .deps/$(BASENAME).$(PREFIX1).dix
	apertium-validate-dictionary $(BASENAME).$(PREFIX1).dix
	lt-comp rl .deps/$(BASENAME).$(PREFIX1).dix $@

###############################################################################
## Constraint grammar disambiguation
###############################################################################

$(PREFIX1).rlx.bin: $(BASENAME).$(PREFIX1).rlx
	cg-comp $(BASENAME).$(PREFIX1).rlx $@

#$(PREFIX2).rlx.bin: $(BASENAME).$(PREFIX1).rlx
#	cg-comp $(BASENAME).$(PREFIX1).rlx $@

###############################################################################
## Structural transfer
###############################################################################

$(PREFIX1).t1x.bin: $(BASENAME).$(PREFIX1).t1x
	apertium-validate-transfer $(BASENAME).$(PREFIX1).t1x
	apertium-preprocess-transfer $(BASENAME).$(PREFIX1).t1x $@

#$(PREFIX2).t1x.bin: $(BASENAME).$(PREFIX2).t1x
#	apertium-validate-transfer $(BASENAME).$(PREFIX2).t1x
#	apertium-preprocess-transfer $(BASENAME).$(PREFIX2).t1x $@

###############################################################################
## Translation modes
###############################################################################

modes/$(PREFIX1).mode: modes.xml
	apertium-validate-modes modes.xml
	apertium-gen-modes modes.xml
	cp *.mode modes/

EXTRA_DIST=$(PREFIX1).prob $(PREFIX2).prob \
           $(BASENAME).$(PREFIX1).t1x \
           $(BASENAME).$(PREFIX2).t1x \
           modes.xml

apertium_tr_azmodesdir=$(prefix)/share/apertium/modes/
apertium_tr_azdir=$(prefix)/share/apertium/apertium-$(PREFIX1)/
apertium_tr_az_DATA=$(PREFIX1).autobil.bin $(PREFIX2).autobil.bin \
                    $(PREFIX1).prob $(PREFIX2).prob \
		    $(PREFIX1).t1x.bin  \
		    $(PREFIX1).rlx.bin  \
		    $(BASENAME).$(PREFIX1).t1x \
		    modes.xml

noinst_DATA=modes/$(PREFIX1).mode

install-data-local:
	mv modes modes.bak
	$(prefix)/bin/apertium-gen-modes modes.xml $(BASENAME)
	rm -rf modes
	mv modes.bak modes
	test -d $(DESTDIR)$(apertium_sme_modesdir) || mkdir $(DESTDIR)$(apertium_tr_azmodesdir)
	$(INSTALL_DATA) $(PREFIX1).mode $(DESTDIR)$(apertium_tr_azmodesdir)
	rm $(PREFIX1).mode
	$(INSTALL_DATA) $(BASENAME).$(PREFIX1).t1x $(DESTDIR)$(apertium_tr_azdir)

CLEANFILES = -r $(TARGETS_COMMON) 
