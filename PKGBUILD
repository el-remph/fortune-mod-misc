pkgname=fortune-mod-misc
pkgdesc="Some fortunes that don't come with fortune-mod"
pkgrel=1
pkgver=0
arch=(any) # fr
depends=() # fr
makedepends=(curl perl sed fortune-mod) # or anything that provides strfile
_out=(ms-fortunes.dat freebsd-murphy.dat cat-v-programming-quotes.dat) # easier to remove extension than add

source=(
	ambians-scrap.pl cat-v-scrap.sed	# regular sources, come with the git repo
	# This is available over TLS with the usual cat-v.org signing key, but it's
	# a pain to persuade makepkg(1) to accept it. Actually easier to just not
	# secure at all, and verify with sha384sum(1) instead
	cat-v-programming-quotes.md::http://quotes.cat-v.org/programming/index.md
)
sha384sums=(
	SKIP SKIP
	22c51d7fc598d8ece29c15b41f8b2f3e17936858423d89d8d0982d99e5c2940696274bcc21fe7912f8a75c38a9931390
)


pkgver() {
	printf 'r%d.%s' `git rev-list --count HEAD` `git rev-parse --short=7 HEAD`
}

prepare() {
	local -r ambians=https://motd.ambians.com/quotes.php/name
	curl --compressed --parallel	\
		"$ambians/linux_ms_fortunes/toc_id/1-1-23/s/[0-130:10]" -o 'ms-fortunes.html.#1'	\
		"$ambians/freebsd_murphys_law/toc_id/1-0-10/s/[0-830:10]" -o 'freebsd-murphy.html.#1'
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
