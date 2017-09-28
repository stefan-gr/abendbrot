# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_COMMIT_SHA="9151f5b43ccaabcd3fe1e85c144402088e8002f4"
inherit libretro-core

DESCRIPTION="Multiplayer Bomberman clone for RetroArch/Libretro"
HOMEPAGE="https://github.com/libretro/mrboom-libretro"
KEYWORDS="amd64 x86"

LICENSE="MIT"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"
