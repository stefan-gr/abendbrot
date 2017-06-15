# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_COMMIT_SHA="d4559ce8a4428c0ba17210420f4d7a56faa3a6a4"
inherit libretro-core

DESCRIPTION="Multiplayer Bomberman clone for RetroArch/Libretro"
HOMEPAGE="https://github.com/libretro/mrboom-libretro"
KEYWORDS="amd64 x86"

LICENSE="MIT"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"
