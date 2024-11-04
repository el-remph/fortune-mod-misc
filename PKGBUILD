pkgname=fortune-mod-ambians
pkgdesc="Fortunes from https://motd.ambians.com that don't come with fortune-mod"
pkgrel=1
pkgver=0
arch=(any) # fr
depends=() # fr
makedepends=(curl perl fortune-mod) # or anything that provides strfile
source=(ambians-scrap.pl)
sha384sums=(SKIP)
url=https://motd.ambians.com/quotes.php/name/

build() {
	curl --compressed "$url/linux_ms_fortunes/toc_id/1-1-23/s/[0-130:10]" | ./ambians-scrap.pl > ms-fortunes
	curl --compressed "$url/freebsd_murphys_law/toc_id/1-0-10/s/[0-830:10]" | ./ambians-scrap.pl > freebsd-murphy
	strfile ms-fortunes
	strfile freebsd-murphy
}

package() {
	install -m 0644 -Dt "$pkgdir"/usr/share/fortune ms-fortunes ms-fortunes.dat freebsd-murphy freebsd-murphy.dat
}
