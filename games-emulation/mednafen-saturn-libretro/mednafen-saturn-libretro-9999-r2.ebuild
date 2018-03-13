# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_REPO_NAME="libretro/${PN/mednafen-saturn/beetle-saturn}"
inherit libretro-core

DESCRIPTION="Standalone port of Mednafen Saturn to the libretro"
HOMEPAGE="https://github.com/libretro/beetle-saturn-libretro"
KEYWORDS=""

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

pkg_setup() {
	LIBRETRO_CORE_NAME="mednafen_saturn"
}
