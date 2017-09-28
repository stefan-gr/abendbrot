# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_COMMIT_SHA="982f31742e13f3083a31c8627eb6bf77824e3c2a"
inherit libretro-core

DESCRIPTION="MAME (0.78) for libretro."
HOMEPAGE="https://github.com/libretro/mame2003-libretro"
KEYWORDS="amd64 x86"

LICENSE="MAME-GPL"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"
