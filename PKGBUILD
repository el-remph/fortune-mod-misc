# SPDX-FileCopyrightText: 2024 The Remph
# SPDX-License-Identifier: FSFULLRWD
# See COPYING

pkgname=fortune-mod-misc
pkgdesc="Some fortunes that don't come with fortune-mod"
pkgrel=1
pkgver=0
arch=(any) # fr
depends=() # fr
makedepends=(curl perl sed fortune-mod) # or anything that provides strfile
# Note that no `license=()' array is given for the package; see COPYING for
# details

# easier to remove extension than add
_out=(	ms-fortunes.dat freebsd-murphy.dat cat-v-programming-quotes.dat
	cat-v.dat freebsd.dat kernelnewbies.dat openbsd.dat)
_off=(offensive/freebsd.dat offensive/men-women.dat)

source=(
	ambians-scrap.pl cat-v-scrap.sed	# regular sources, come with the git repo
	https://github.com/jvzantvoort/fortune/raw/main/content/fortunes/{cat-v,freebsd,kernelnewbies,openbsd,offensive/{freebsd_offensive,men-women}}.fortune
	# This is available over TLS with the usual cat-v.org signing key, but it's
	# a pain to persuade makepkg(1) to accept it. Actually easier to just not
	# secure at all, and verify with sha384sum(1) instead
	cat-v-programming-quotes.md::http://quotes.cat-v.org/programming/index.md
)
sha384sums=(
	SKIP SKIP
	69401f90962ad9cb3ea2b0b814f4d5f592624c955e8b9c68f84ab4c616378245f2cba0fbc34659bdbbfd349bfd4bb240
	63b254b5497f3b9bc91570ddda731cf80341fbdb83371c94b72687170da37100fbbffbc980fd6ecddb4d75c079a3c441
	393b9bf62690c8306956c86f1c411aaeff136e6df74d3f0c3e51a9966d22037b7230c1fb7075df648de83ec250d57322
	d972c8130abd025a21b57d5c8f6565938541012bcb4bb28adaf7fbcd3cc2094154cf688df994fe1045efa77c80e1469d
	dadf204fcb366f8abf54bb478543be566a002eaca6b4038a024750e34d21579dcfcf215f2b1630c064c4ba66b5c7d8d5
	92599934045e21478a465ba46405d87e56f470ddd805fb8599f4b015a424b62718033e828e8b32f27552ce7dc746e26f
	517acababfecc4751e771fc3902c4500f7ff0777d57add36e4279b5df02312993e39052bc9dc6ec37177026e0936379e
)


pkgver() {
	printf 'r%d.%s' `git rev-list --count HEAD` `git rev-parse --short=7 HEAD`
}

prepare() {
	local -r ambians=https://motd.ambians.com/quotes.php/name
	curl --compressed --parallel	\
		"$ambians/linux_ms_fortunes/toc_id/1-1-23/s/[0-130:10]" -o 'ms-fortunes.html.#1'	\
		"$ambians/freebsd_murphys_law/toc_id/1-0-10/s/[0-830:10]" -o 'freebsd-murphy.html.#1'

	# Maybe should've done this in the sources array
	mkdir -p offensive
	# ln(1) used instead of mv(1) so the sources can still be verified with sums
	ln -f freebsd_offensive.fortune offensive/freebsd
	ln -f men-women.fortune offensive/men-women
	local i
	for i in *.fortune; do
		ln -f $i ${i%.fortune}
	done
}

build() {
	local i
	for i in ms-fortunes freebsd-murphy; do
		./ambians-scrap.pl $i.html.* > $i
	done

	./cat-v-scrap.sed cat-v-programming-quotes.md > cat-v-programming-quotes

	for i in ${_out[@]%.dat} ${_off[@]%.dat}; do
		strfile $i
	done
}

package() {
	install -m 0644 -Dt "$pkgdir"/usr/share/fortune ${_out[@]} ${_out[@]%.dat}
	cp -RLt "$pkgdir"/usr/share/fortune/ offensive
}
