# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_COMMIT_SHA="13d949c20d5cb7b15997e02481d3596c3aaf0b6c"
inherit libretro-core

DESCRIPTION="libretro implementation of Gambatte. (Game Boy/Game Boy Color)"
HOMEPAGE="https://github.com/libretro/gambatte-libretro"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-2"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"
