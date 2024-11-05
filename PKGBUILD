pkgname=fortune-mod-misc
pkgdesc="Some fortunes that don't come with fortune-mod"
pkgrel=1
pkgver=0
arch=(any) # fr
depends=() # fr
source=(ambians-scrap.pl cat-v-scrap.sed)
makedepends=(curl perl sed fortune-mod) # or anything that provides strfile
sha384sums=(SKIP SKIP)
_curlopt='--compressed --no-progress-meter'

pkgver() {
	printf 'r%d.%s' `git rev-list --count HEAD` `git rev-parse --short=7 HEAD`
}

build() {
	local i
	local -a pids=()

	for i in 'linux_ms_fortunes 1-1-23 130 ms-fortunes' 'freebsd_murphys_law 1-0-10 830 freebsd-murphy'; do
		set -- $i
		{
			curl $_curlopt "https://motd.ambians.com/quotes.php/name/$1/toc_id/$2/s/[0-$3:10]" |
				./ambians-scrap.pl >$4
			strfile "$4"
		} &
		pids+=($!)
	done

	{
		curl $_curlopt --insecure https://quotes.cat-v.org/programming/index.md |
			./cat-v-scrap.sed > cat-v-programming-quotes
		strfile cat-v-programming-quotes
	} &
	pids+=($!)

	for i in ${pids[@]}; do
		wait $i
	done
}

package() {
	local -a _out=(ms-fortunes.dat freebsd-murphy.dat cat-v-programming-quotes.dat) # easier to remove extension than add
	install -m 0644 -Dt "$pkgdir"/usr/share/fortune ${_out[@]} ${_out[@]%.dat}
}
