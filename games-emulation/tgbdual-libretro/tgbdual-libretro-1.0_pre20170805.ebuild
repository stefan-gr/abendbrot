# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_COMMIT_SHA="df69141779724bbb6e64aa66a00268002f36fbea"
inherit libretro-core

DESCRIPTION="libretro implementation of TGB-DUAL. (Game Boy Advance)"
HOMEPAGE="https://github.com/libretro/tgbdual-libretro"
KEYWORDS="amd64 x86"

LICENSE="GPL-2"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"
