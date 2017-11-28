# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_COMMIT_SHA="7ce4fba7ea3cf966012a8c2fc5438701e09f26d9"
inherit libretro-core

DESCRIPTION="MAME2000 (0.37b5) for libretro."
HOMEPAGE="https://github.com/libretro/mame2000-libretro"
KEYWORDS="amd64 x86"

LICENSE="MAME-GPL"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"
