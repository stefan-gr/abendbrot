# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_COMMIT_SHA="cb300293ff7825ab445c0eb7d8998674aa97a406"
inherit libretro-core

DESCRIPTION="MAME (0.174) for libretro."
HOMEPAGE="https://github.com/libretro/mame2016-libretro"
KEYWORDS="amd64 x86"

LICENSE="MAME-GPL"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"
