pkgname=fortune-mod-ms
pkgdesc='ms-fortunes: parodies of Micro$oft, in fortune format'
pkgrel=1
pkgver=0
arch=(any) # fr
depends=() # fr
makedepends=(curl perl fortune-mod) # or anything that provides strfile
source=(ambians-scrap.pl)
sha384sums=(SKIP)
url=https://motd.ambians.com/quotes.php/name/linux_ms_fortunes/toc_id/1-1-23

build() {
	curl --compressed "$url/s/[0-130:10]" | ./ambians-scrap.pl > ms-fortunes
	strfile ms-fortunes
}

package() {
	install -m 0644 -Dt $pkgdir/usr/share/fortune ms-fortunes ms-fortunes.dat
}
