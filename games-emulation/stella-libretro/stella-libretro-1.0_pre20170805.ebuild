# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_COMMIT_SHA="abcd658fe8e401f24cc4de8eff30154601b97b04"
inherit libretro-core

DESCRIPTION="libretro implementation of Stella. (Atari 2600)"
HOMEPAGE="https://github.com/libretro/stella-libretro"
KEYWORDS="amd64 x86"

LICENSE="GPL-2"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"
