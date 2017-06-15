# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_COMMIT_SHA="675a8385b366afce86a7f04603e216e24779ac9e"
inherit libretro-core

DESCRIPTION="libretro implementation of Gambatte. (Game Boy/Game Boy Color)"
HOMEPAGE="https://github.com/libretro/gambatte-libretro"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-2"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"
