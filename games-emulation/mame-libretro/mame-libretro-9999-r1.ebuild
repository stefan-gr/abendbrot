# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit libretro-core

DESCRIPTION="libretro implementation of MAME 2015. (Arcade)"
HOMEPAGE="https://github.com/libretro/mame"
SRC_URI=""

EGIT_REPO_URI="https://github.com/libretro/mame.git"

LICENSE="MAME-GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

src_compile() {
	emake -f Makefile.libretro || die "emake failed"
}

src_install() {
	insinto ${LIBRETRO_DATA_DIR}/mame_libretro
	doins "${S}"/docs/mamelicense.txt
	libretro-core_src_install
}
