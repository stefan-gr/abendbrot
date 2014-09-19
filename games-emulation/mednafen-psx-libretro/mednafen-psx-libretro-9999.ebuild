# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

DESCRIPTION="libretro implementation of Mednafen PSX. (PlayStation)"
HOMEPAGE="https://github.com/libretro/beetle-psx-libretro"
SRC_URI=""

EGIT_REPO_URI="https://github.com/libretro/beetle-psx-libretro.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=""
DEPEND=""

src_unpack() {
	git-r3_fetch https://github.com/libretro/libretro-super.git HEAD
	git-r3_checkout https://github.com/libretro/libretro-super.git \
		"${WORKDIR}"/infos
	git-r3_fetch
	git-r3_checkout
}

src_compile() {
	emake core=psx || die "emake failed"
}

src_install() {
	insinto /usr/$(get_libdir)/libretro
	doins "${S}"/mednafen_psx_libretro.so
	doins "${WORKDIR}"/infos/dist/info/mednafen_psx_libretro.info
}
