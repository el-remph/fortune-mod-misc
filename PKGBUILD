pkgname=fortune-mod-misc
pkgdesc="Some fortunes that don't come with fortune-mod"
pkgrel=1
pkgver=0
arch=(any) # fr
depends=() # fr
source=(ambians-scrap.pl cat-v-scrap.sed)
makedepends=(curl perl sed fortune-mod) # or anything that provides strfile
sha384sums=(SKIP SKIP)
_out=(ms-fortunes.dat freebsd-murphy.dat cat-v-programming-quotes.dat) # easier to remove extension than add

pkgver() {
	printf 'r%d.%s' `git rev-list --count HEAD` `git rev-parse --short=7 HEAD`
}

prepare() {
	local -r ambians=https://motd.ambians.com/quotes.php/name
	curl --compressed --parallel	\
		"$ambians/linux_ms_fortunes/toc_id/1-1-23/s/[0-130:10]" -o 'ms-fortunes.html.#1'	\
		"$ambians/freebsd_murphys_law/toc_id/1-0-10/s/[0-830:10]" -o 'freebsd-murphy.html.#1'	\
		--insecure https://quotes.cat-v.org/programming/index.md -o cat-v-programming-quotes.md
}

build() {
	local i

	for i in ms-fortunes freebsd-murphy; do
		./ambians-scrap.pl $i.html.* > $i
	done
	./cat-v-scrap.sed cat-v-programming-quotes.md > cat-v-programming-quotes

	for i in ${_out[@]%.dat}; do
		strfile $i
	done
}

package() {
	install -m 0644 -Dt "$pkgdir"/usr/share/fortune ${_out[@]} ${_out[@]%.dat}
}
