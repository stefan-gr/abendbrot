# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

DESCRIPTION="libretro implementation of MAME 2013 (0.152). (Arcade)"
HOMEPAGE="https://github.com/libretro/mame2013-libretro"
SRC_URI=""

EGIT_REPO_URI="https://github.com/libretro/mame2013-libretro.git"

LICENSE="MAME-GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=""
DEPEND=""
S="${S}/0152"
src_prepare() {
	git-r3_fetch https://github.com/libretro/libretro-super.git HEAD 
	git-r3_checkout https://github.com/libretro/libretro-super.git \
		"${WORKDIR}"/infos
	git-r3_checkout
}

src_compile() {
	emake -f Makefile.libretro || die "emake failed"
}

src_install() {
	insinto /usr/$(get_libdir)/libretro
	doins "${S}"/mame_libretro.so
	doins "${WORKDIR}"/infos/dist/info/mame_libretro.info
	insinto /usr/share/libretro/mame_libretro
	doins "${S}"/docs/license.txt
}
