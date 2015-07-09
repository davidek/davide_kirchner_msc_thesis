# Build the latex doc, ralying on latexmk

DOCNAME = davide_kirchner_thesis

.PHONY: all
all: $(DOCNAME).pdf kirchner_preliminary_stateoftheart.pdf

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

.PHONY: tex_outdir/kirchner_preliminary_stateoftheart.pdf
tex_outdir/kirchner_preliminary_stateoftheart.pdf: kirchner_preliminary_stateoftheart.tex
	latexmk -pdf -outdir=tex_outdir \
		-pdflatex="pdflatex" \
		-use-make \
		kirchner_preliminary_stateoftheart.tex

kirchner_preliminary_stateoftheart.pdf: tex_outdir/kirchner_preliminary_stateoftheart.pdf
	ln -s -f tex_outdir/kirchner_preliminary_stateoftheart.pdf kirchner_preliminary_stateoftheart.pdf


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
