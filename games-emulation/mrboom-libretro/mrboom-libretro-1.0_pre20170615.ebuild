# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_COMMIT_SHA="1e3fbd0bfde59ac7f14d51c0cb6dcb02bd53e819"
inherit libretro-core

DESCRIPTION="Multiplayer Bomberman clone for RetroArch/Libretro"
HOMEPAGE="https://github.com/libretro/mrboom-libretro"
KEYWORDS="~amd64 ~x86"

LICENSE="MIT"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"
