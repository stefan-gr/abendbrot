# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit libretro-core

DESCRIPTION="libretro implementation of Mednafen SNES. (Super Nintendo Entertainment System)"
HOMEPAGE="https://github.com/libretro/beetle-bsnes-libretro"
SRC_URI="https://github.com/libretro/beetle-bsnes-libretro/archive/d25e927b35edd7bfec34e4203a1cd00724dc632b.tar.gz -> ${P}.tar.gz"
RESTRICT="primaryuri"

S="${WORKDIR}/beetle-bsnes-libretro-d25e927b35edd7bfec34e4203a1cd00724dc632b"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/libretro/beetle-bsnes-libretro.git"
	KEYWORDS=""
else
	KEYWORDS="amd64 x86"
fi

LICENSE="GPL-2"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

LIBRETRO_CORE_NAME=mednafen_snes

src_compile() {
	emake core=snes || die "emake failed"
}
