# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_COMMIT_SHA="2952ebfb21f281fce91350fed2602e2630c5b887"
inherit libretro-core

DESCRIPTION="An unofficial libretro port of the EasyRPG/Player."
HOMEPAGE="https://github.com/libretro/easyrpg-libretro"
KEYWORDS="amd64 x86"

LICENSE="GPL-3"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

S="${S}/builds/libretro"
