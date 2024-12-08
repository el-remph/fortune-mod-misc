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
source=(GNUmakefile ambians-scrap.pl cat-v-scrap.sed)
sha384sums=(SKIP SKIP SKIP)

pkgver() (
	set -o pipefail
	git describe --long --tags | sed -e s/^v// -e s/-/.r/ -e y/-/./ ||
		printf 'r%d.%s' `git rev-list --count HEAD` `git rev-parse --short=7 HEAD`
)
prepare() {
	make download
}
build() {
	make
}
package() {
	make DESTDIR="$pkgdir" install
}
