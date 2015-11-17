# Build the latex doc, ralying on latexmk

DOCNAME = davide_kirchner_thesis
SLIDES = davide_kirchner_thesis_slides
HANDOUT = davide_kirchner_thesis_handout
STATEOFTHEART = kirchner_preliminary_stateoftheart

.PHONY: all
all: $(DOCNAME).pdf $(SLIDES).pdf $(HANDOUT).pdf $(HANDOUT)-2p.pdf

# CUSTOM BUILD RULES

# In case you didn't know, '$@' is a variable holding the name of the target,
# and '$<' is a variable holding the (first) dependency of a rule.
# "raw2tex" and "dat2tex" are just placeholders for whatever custom steps
# you might have.

#%.tex: %.raw
#	./raw2tex $< > $@

#%.tex: %.dat
#	./dat2tex $< > $@


# MAIN LATEXMK RULE

# -pdf tells latexmk to generate PDF directly (instead of DVI).
# -pdflatex="" tells latexmk to call a specific backend with specific options.
# -use-make tells latexmk to call make for generating missing files.

# -interactive=nonstopmode keeps the pdflatex backend from stopping at a
# missing file reference and interactively asking you for an alternative.

.PHONY: tex_outdir/$(DOCNAME).pdf  # latexmk shall always run
tex_outdir/$(DOCNAME).pdf: $(DOCNAME).tex
	latexmk -pdf -outdir=tex_outdir \
		-pdflatex="pdflatex" \
		-use-make \
		$(DOCNAME).tex
	@# my pdflatex does not seem to understand this:
	@#-pdflatex="pdflatex -interactive=nonstopmode" \


$(DOCNAME).pdf: tex_outdir/$(DOCNAME).pdf
	ln -s -f tex_outdir/$(DOCNAME).pdf $(DOCNAME).pdf

.PHONY: tex_outdir/$(STATEOFTHEART).pdf  # latexmk shall always run
tex_outdir/$(STATEOFTHEART).pdf: $(STATEOFTHEART).tex
	latexmk -pdf -outdir=tex_outdir \
		-pdflatex="pdflatex" \
		-use-make \
		$(STATEOFTHEART).tex
	@# my pdflatex does not seem to understand this:
	@#-pdflatex="pdflatex -interactive=nonstopmode" \


$(STATEOFTHEART).pdf: tex_outdir/$(STATEOFTHEART).pdf
	ln -s -f tex_outdir/$(STATEOFTHEART).pdf $(STATEOFTHEART).pdf

.PHONY: tex_outdir/$(SLIDES).pdf  # latexmk shall always run
tex_outdir/$(SLIDES).pdf: $(SLIDES).tex
	latexmk -pdf -outdir=tex_outdir \
		-pdflatex='pdflatex' \
		-use-make \
		$(SLIDES).tex
	@# my pdflatex does not seem to understand this:
	@#-pdflatex="pdflatex -interactive=nonstopmode" \


$(SLIDES).pdf: tex_outdir/$(SLIDES).pdf
	ln -s -f tex_outdir/$(SLIDES).pdf $(SLIDES).pdf

.PHONY: tex_outdir/$(HANDOUT).pdf  # latexmk shall always run
tex_outdir/$(HANDOUT).pdf: $(HANDOUT).tex
	latexmk -pdf -outdir=tex_outdir \
		-pdflatex="pdflatex" \
		-use-make \
		$(HANDOUT).tex
	@# my pdflatex does not seem to understand this:
	@#-pdflatex="pdflatex -interactive=nonstopmode" \


$(HANDOUT).pdf: tex_outdir/$(HANDOUT).pdf
	ln -s -f tex_outdir/$(HANDOUT).pdf $(HANDOUT).pdf

$(HANDOUT)-2p.pdf: tex_outdir/$(HANDOUT).pdf
	pdfnup --a4paper --keepinfo --nup 1x2 --frame true \
	  --scale 0.90 --delta '1cm 1cm' --no-landscape --outfile $@ $<

# vim spellfile
.vimspell.words.add.spl: .vimspell.words.add
	vim -i NONE -u NORC -U NONE -V1 -nNesc \
		'execute ":mkspell! " . fnameescape(".vimspell.words.add") | echo "" | qall!'
.PHONY: spell
spell: .vimspell.words.add.spl

.PHONY: clean
clean:
	latexmk -CA

##DIR=./out.nosync
#FILE=davide_kirchner_thesis.tex
#BASE=`basename $FILE .tex`

##mkdir -p $DIR
##latex -output-directory $DIR $FILE
##cp $FILE davide_kirchner_thesis.bib $DIR
##bibtex $DIR/$BASE
##bibtex $DIR/$BASE
##latex -output-directory $DIR $FILE
##latex -output-directory $DIR $FILE

#pdflatex $FILE
#bibtex $BASE
#bibtex $BASE
#pdflatex $FILE
#pdflatex $FILE
##dvipdf $BASE.dvi $BASE.pdf
