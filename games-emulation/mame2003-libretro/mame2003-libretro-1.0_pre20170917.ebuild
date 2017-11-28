# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_COMMIT_SHA="1980779b676fad1402f6a460973118bcbcd48165"
inherit libretro-core

DESCRIPTION="MAME (0.78) for libretro."
HOMEPAGE="https://github.com/libretro/mame2003-libretro"
KEYWORDS="amd64 x86"

LICENSE="MAME-GPL"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"
