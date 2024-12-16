AMBIANS_URL	= https://motd.ambians.com/quotes.php/name
AMBIANS_MS	:= $(foreach n,$(shell seq 0 10 130),ms-fortunes.html.$n)
AMBIANS_MURPHY	:= $(foreach n,$(shell seq 0 10 830),freebsd-murphy.html.$n)

JVZANTVOORT_URL	= https://github.com/jvzantvoort/fortune/raw/main/content/fortunes
JVZANTVOORT_FORTUNES	= cat-v freebsd kernelnewbies openbsd offensive/freebsd offensive/men-women
# The difference of freebsd_offensive means this must be done by hand. Good
# thing too, the makefile syntax to swap out spaces for commas is putrid
JVZANTVOORT_DOWNLOAD	= cat-v,freebsd,kernelnewbies,openbsd,offensive/freebsd_offensive,offensive/men-women

FORTUNES = ms-fortunes freebsd-murphy cat-v-programming-quotes ${JVZANTVOORT_FORTUNES}
TARGETS = ${FORTUNES} ${FORTUNES:=.dat}
all: ${TARGETS}

# not /usr/local since fortune-mod compiles in this default
PREFIX = /usr
install: all
	install -m 0644 -Dt ${DESTDIR}${PREFIX}/share/fortune $(filter-out offensive/%,${TARGETS})
	install -m 0644 -Dt ${DESTDIR}${PREFIX}/share/fortune/off $(filter offensive/%,${TARGETS})

DL = ${AMBIANS_MS} ${AMBIANS_MURPHY} ${JVZANTVOORT_FORTUNES} cat-v-programming-quotes.md
download: ${DL} # Phony target for PKGBUILD

clean_download:
	rm -f ${DL}
clean_fortunes:
	rm -f ${TARGETS}
clean: clean_download clean_fortunes

.PHONY = all install download clean clean_download clean_fortunes

offensive:
	mkdir offensive
${DL} &:| offensive
	curl -L --compressed --parallel	\
		"${AMBIANS_URL}/linux_ms_fortunes/toc_id/1-1-23/s/[0-130:10]" -o 'ms-fortunes.html.#1'	\
		"${AMBIANS_URL}/freebsd_murphys_law/toc_id/1-0-10/s/[0-830:10]" -o 'freebsd-murphy.html.#1'	\
		'${JVZANTVOORT_URL}/{${JVZANTVOORT_DOWNLOAD}}.fortune' -o '#1'	\
		-k https://quotes.cat-v.org/programming/index.md -o cat-v-programming-quotes.md
	mv offensive/freebsd_offensive offensive/freebsd

ms-fortunes: ${AMBIANS_MS}
freebsd-murphy: ${AMBIANS_MURPHY}
ms-fortunes freebsd-murphy:
	./ambians-scrap.pl $^ > $@
cat-v-programming-quotes: cat-v-programming-quotes.md
	./cat-v-scrap.sed $^ > $@

%.dat: %
	strfile $^
