# Makefile for marginnote
# Copyright (c) Markus Kohm, 2005-2016
# --------------------------------------------------------------------------
# $Id$
# --------------------------------------------------------------------------

AUXSUFFIXES = aux dvi glo gls idx ind log synctex.gz toc

SOURCE     = marginnote.dtx
TDSSOURCE  = $(SOURCE) README.txt
TDSDOC     = marginnote.pdf
TDSLATEX   = marginnote.sty
DIST       = $(TDSSOURCE) $(TDSDOC)
UNPACKED   = README.txt $(TDSLATEX)

all: $(UNPACKED) $(TDSDOC)

$(UNPACKED): $(SOURCE)
	tex $<

$(TDSDOC): $(SOURCE)
	pdflatex $<
	mkindex $(basename $<)
	pdflatex $<

dist: $(TDSSOURCE) $(TDSDOC) $(TDSLATEX)
	ctanify -p marginnote $(TDSSOURCE) $(TDSDOC) $(TDSLATEX)

clean:
	@rm -f *~ \
	       $(foreach auxsuffix,$(AUXSUFFIXES),$(addsuffix .$(auxsuffix),$(basename $(SOURCE))) ) \
	       $(UNPACKED) $(TDSDOC)
