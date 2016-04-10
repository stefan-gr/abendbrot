# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit libretro-core

DESCRIPTION="libretro implementation of SNES9x Next. (Super Nintendo Entertainment System)"
HOMEPAGE="https://github.com/libretro/snes9x-next"
SRC_URI=""

EGIT_REPO_URI="https://github.com/libretro/snes9x-next.git"

LICENSE="snes9x"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

LIBRETRO_CORE_NAME=snes9x_next

src_compile() {
	emake -f Makefile.libretro
}

src_install() {

	insinto "${LIBRETRO_DATA_DIR}"/snes9x_next_libretro
	doins "${S}"/docs/snes9x-license.txt
	prepgamesdirs
}
