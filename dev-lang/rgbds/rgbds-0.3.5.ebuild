# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs

DESCRIPTION="Rednex GameBoy Development System"
HOMEPAGE="https://github.com/rednex/rgbds"
SRC_URI="https://github.com/rednex/rgbds/releases/download/v${PV}/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="sys-devel/flex
media-libs/libpng
dev-util/byacc
virtual/pkgconfig"
RDEPEND="media-libs/libpng"

src_prepare() {
    tc-export CC
    default
}

src_compile() {
    emake all CFLAGS="${CFLAGS}" PKG_CONFIG="$(tc-getPKG_CONFIG)" WARNFLAGS= STRIP= Q=
}

src_install() {
    emake install DESTDIR="${D}" PREFIX="/usr" mandir="/usr/share/man" STRIP= Q=
}
