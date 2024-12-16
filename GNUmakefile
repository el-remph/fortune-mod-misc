AMBIANS_URL	= https://motd.ambians.com/quotes.php/name
AMBIANS_MS	:= $(foreach n,$(shell seq 0 10 130),ms-fortunes.d/$n)
AMBIANS_MURPHY	:= $(foreach n,$(shell seq 0 10 830),freebsd-murphy.d/$n)

JVZANTVOORT_URL	= https://github.com/jvzantvoort/fortune/raw/main/content/fortunes
JVZANTVOORT_FORTUNES	= cat-v freebsd kernelnewbies openbsd offensive/freebsd offensive/men-women
JVZANTVOORT_DOWNLOAD	= cat-v freebsd kernelnewbies openbsd offensive/freebsd_offensive offensive/men-women

FORTUNES = ms-fortunes freebsd-murphy cat-v-programming-quotes ${JVZANTVOORT_FORTUNES}
TARGETS = ${FORTUNES} ${FORTUNES:=.dat}
all: ${TARGETS}

# not /usr/local since fortune-mod compiles in this default
PREFIX = /usr
install: all
	install -m 0644 -Dt ${DESTDIR}${PREFIX}/share/fortune $(filter-out offensive/%,${TARGETS})
	install -m 0644 -Dt ${DESTDIR}${PREFIX}/share/fortune/off $(filter offensive/%,${TARGETS})

WGET = wget --compression=auto --no-verbose --no-clobber --continue -nH
DL = ${AMBIANS_MS} ${AMBIANS_MURPHY} ${JVZANTVOORT_FORTUNES} cat-v-programming-quotes.md
download: ${DL} # Phony target for PKGBUILD

clean_download:
	rm -f ${DL}
clean_fortunes:
	rm -f ${TARGETS}
clean: clean_download clean_fortunes
	rmdir ms-fortunes.d freebsd-murphy.d offensive

.PHONY = all install download clean clean_download clean_fortunes

ms-fortunes.d freebsd-murphy.d:
	mkdir $@
${AMBIANS_MS} &:| ms-fortunes.d
	cd $| && ${WGET} -nd $(foreach n,$(shell seq 0 10 130),"${AMBIANS_URL}/linux_ms_fortunes/toc_id/1-1-23/s/$n")
${AMBIANS_MURPHY} &:| freebsd-murphy.d
	cd $| && ${WGET} -nd $(foreach n,$(shell seq 0 10 830),"${AMBIANS_URL}/freebsd_murphys_law/toc_id/1-0-10/s/$n" )
${JVZANTVOORT_FORTUNES} &:
	${WGET} -x --cut-dirs=6 $(foreach i,${JVZANTVOORT_DOWNLOAD},${JVZANTVOORT_URL}/$i.fortune)
	mv offensive/freebsd_offensive.fortune offensive/freebsd.fortune
	set -ex; for i in ${JVZANTVOORT_FORTUNES}; do mv $$i.fortune $$i; done
cat-v-programming-quotes.md:
	${WGET} -O $@ --no-check-certificate https://quotes.cat-v.org/programming/index.md

ms-fortunes: ${AMBIANS_MS}
freebsd-murphy: ${AMBIANS_MURPHY}
ms-fortunes freebsd-murphy:
	./ambians-scrap.pl $^ > $@
cat-v-programming-quotes: cat-v-programming-quotes.md
	./cat-v-scrap.sed $^ > $@

%.dat: %
	strfile $^
