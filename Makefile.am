###############################################################################
## Makefile for Turkish--Azerbaijani
###############################################################################

LANG1=tur
LANG2=aze
PREFIX1=$(LANG1)-$(LANG2)
PREFIX2=$(LANG2)-$(LANG1)

BASENAME=apertium-$(PREFIX1)

SUBDIRS = morph-tur morph-aze .

TARGETS_COMMON = $(PREFIX1).autobil.bin $(PREFIX2).autobil.bin  \
	$(PREFIX1).t1x.bin $(PREFIX1).rlx.bin

@ap_include@

###############################################################################
## Bilingual dictionaries
###############################################################################

.deps/$(BASENAME).$(PREFIX1).dix: $(BASENAME).$(PREFIX1).dix lexchoicebil.xsl
	if [ ! -d .deps ]; then $(MKDIR_P) .deps; fi
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

EXTRA_DIST=$(PREFIX1).prob $(PREFIX2).prob \
           $(BASENAME).$(PREFIX1).t1x \
           $(BASENAME).$(PREFIX2).t1x \
           modes.xml

apertium_tur_azedir=$(prefix)/share/apertium/apertium-$(PREFIX1)/
apertium_tur_aze_DATA=$(PREFIX1).autobil.bin \
                    $(PREFIX1).automorf.hfst \
                    $(PREFIX1).prob $(PREFIX2).prob \
		    $(PREFIX1).t1x.bin  \
		    $(PREFIX1).rlx.bin  \
		    $(BASENAME).$(PREFIX1).t1x \
		    modes.xml

noinst_DATA=modes/$(PREFIX1).mode

install-data-local: install-modes
	$(INSTALL_DATA) $(BASENAME).$(PREFIX1).t1x $(DESTDIR)$(apertium_tur_azedir)

CLEANFILES = -r $(TARGETS_COMMON)
