# Makefile for marginnote
# Copyright (c) Markus Kohm, 2005-2016
# --------------------------------------------------------------------------
# $Id$
# --------------------------------------------------------------------------

AUXSUFFIXES = aux dvi glo gls ilg idx ind log synctex.gz toc

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
	ctanify -p marginnote $(TDSSOURCE) $(TDSDOC) $(TDSLATEX) --tdsonly $(TDSLATEX)

clean:
	@rm -f *~ pdftest.* luatest.* \
	       $(foreach auxsuffix,$(AUXSUFFIXES),$(addsuffix .$(auxsuffix),$(basename $(SOURCE))) ) \
	       $(UNPACKED) $(TDSDOC)

allclean: clean
	@rm -rf auto marginnote.tar.gz

test: pdftest.pdf luatest.pdf biditest.pdf

pdftest.pdf: test-marginnote.tex $(TDSLATEX)
	@cp -f test-marginnote.tex pdftest.tex
	pdflatex pdftest.tex
	pdflatex pdftest.tex
	@rm -f pdftest.aux pdftest.log pdftest.tex

luatest.pdf: test-marginnote.tex $(TDSLATEX)
	@cp -f test-marginnote.tex luatest.tex
	lualatex luatest.tex
	lualatex luatest.tex
	@rm -f luatest.aux luatest.log luatest.tex

biditest.pdf: testbidi-marginnote.tex $(TDSLATEX)
	@cp -f testbidi-marginnote.tex biditest.tex
	xelatex biditest.tex
	xelatex biditest.tex
	@rm -f biditest.aux biditest.log biditest.tex
