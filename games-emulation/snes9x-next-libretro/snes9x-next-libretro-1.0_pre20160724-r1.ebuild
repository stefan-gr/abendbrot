# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit libretro-core

DESCRIPTION="libretro implementation of SNES9x Next. (Super Nintendo Entertainment System)"
HOMEPAGE="https://github.com/libretro/snes9x-next"
SRC_URI="https://github.com/libretro/snes9x-next/archive/4b7fad592eff28db53b8ddc021f67cec3bdbdaa0.tar.gz -> ${P}.tar.gz"
RESTRICT="primaryuri"

S="${WORKDIR}/snes9x-next-4b7fad592eff28db53b8ddc021f67cec3bdbdaa0"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/libretro/snes9x-next.git"
	KEYWORDS=""
else
	KEYWORDS="amd64 x86"
fi

LICENSE="snes9x"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

LIBRETRO_CORE_NAME=snes9x_next

src_compile() {
	emake -f Makefile.libretro
}

src_install() {
	insinto "${LIBRETRO_DATA_DIR}"/snes9x_next_libretro
	doins "${S}"/docs/snes9x-license.txt
}
