# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_REPO_NAME="libretro/${PN/mednafen-snes/beetle-bsnes}"
inherit libretro-core

DESCRIPTION="libretro implementation of Mednafen SNES. (Super Nintendo Entertainment System)"
HOMEPAGE="https://github.com/libretro/beetle-bsnes-libretro"
KEYWORDS=""

LICENSE="GPL-2"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

LIBRETRO_CORE_NAME=mednafen_snes
