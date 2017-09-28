# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_COMMIT_SHA="4027bf6fd0c2330ad8e017fd6a8ace4ea2c9cc63"
inherit libretro-core

DESCRIPTION="MAME2000 (0.37b5) for libretro."
HOMEPAGE="https://github.com/libretro/mame2000-libretro"
KEYWORDS="amd64 x86"

LICENSE="MAME-GPL"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"
