all:	clean bib pdf 

pdf: 
	latex bub.tex
	latex bub.tex
	#dvipdfm bub.dvi
	dvips -o bub.ps -Ppdf -G0 -t a4 bub.dvi
	ps2pdf -sPAPERSIZE=a4 -dPDFSETTINGS=/prepress -dEmbedAllFonts=true bub.ps
	evince bub.pdf &

publish:
	s3cmd put --acl-public bub.pdf s3://www.jaumebarcelo.info/papers/


bib:	
	latex bub.tex
	bibtex bub
	latex bub.tex
					
clean:
	rm -f bub.aux bub.log bub.blg bub.bbl bub.out bub.dvi bub.ps bub.pdf diff*

differences:
	cp bub.tex new.tex
	#git show HEAD~10:bub.tex>old.tex
	latexdiff old.tex new.tex > bub_diff.tex
	latex bub_diff.tex
	latex bub_diff.tex
	bibtex bub_diff
	latex bub_diff.tex
	latex bub_diff.tex
	dvips -o bub_diff.ps -Ppdf -G0 -t a4 bub_diff.dvi
	ps2pdf -sPAPERSIZE=a4 -dPDFSETTINGS=/prepress -dEmbedAllFonts=true bub_diff.ps
	evince bub_diff.pdf &
	cp bub_diff.pdf /media/USB20FD/upf2012/webs/s3web/papers/
	s3cmd put --acl-public bub_diff.pdf s3://www.jaumebarcelo.info/papers/

