pkgname=fortune-mod-misc
pkgdesc="Some fortunes that don't come with fortune-mod"
pkgrel=1
pkgver=0
arch=(any) # fr
depends=() # fr
makedepends=(curl perl perl-html-parser fortune-mod) # or anything that provides strfile
source=(ambians-scrap.pl cat-v-scrap.pl)
sha384sums=(SKIP SKIP)
_out=(ms-fortunes.dat freebsd-murphy.dat cat-v-programming-quotes.dat) # easier to remove extension than add

pkgver() {
	printf 'r%d.%s' `git rev-list --count HEAD` `git rev-parse --short=7 HEAD`
}

build() {
	local ambians=https://motd.ambians.com/quotes.php/name curlopt=--compressed i
	curl $curlopt "$ambians/linux_ms_fortunes/toc_id/1-1-23/s/[0-130:10]" | ./ambians-scrap.pl > ms-fortunes
	curl $curlopt "$ambians/freebsd_murphys_law/toc_id/1-0-10/s/[0-830:10]" | ./ambians-scrap.pl > freebsd-murphy
	curl $curlopt --insecure https://quotes.cat-v.org/programming/ | ./cat-v-scrap.pl > cat-v-programming-quotes
	for i in ${_out[@]%.dat}; do
		strfile $i
	done
}

package() {
	install -m 0644 -Dt "$pkgdir"/usr/share/fortune ${_out[@]} ${_out[@]%.dat}
}
