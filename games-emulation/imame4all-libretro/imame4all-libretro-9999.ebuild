# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3

DESCRIPTION="libretro implementation of iMAME4all based on MAME 0.37b5. (Arcade)"
HOMEPAGE="https://github.com/libretro/imame4all-libretro"
SRC_URI=""

EGIT_REPO_URI="https://github.com/libretro/imame4all-libretro.git"

LICENSE="MAME-GPL"
SLOT="0"
KEYWORDS=""
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
	use amd64 && emake -f makefile.libretro
	use x86 && emake -f makefile.libretro
	use arm && emake -f makefile.libretro ARM=1
	use arm64 && emake -f makefile.libretro ARM=1
}

src_install() {
	insinto /usr/$(get_libdir)/libretro
	newins "${S}"/libretro.so imame4all_libretro.so
	insinto /usr/share/libretro/info/
	doins "${WORKDIR}"/infos/dist/info/imame4all_libretro.info
	insinto /usr/share/libretro/imame4all_libretro
	doins "${S}"/res/Applications/iMAME4all.app/LICENSE/LICENSE_MAME.txt
}
