# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_REPO_NAME="libretro/${PN//-libretro}"
inherit libretro-core

DESCRIPTION="libretro implementation of DeSmuME. (Nintendo DS)"
HOMEPAGE="https://github.com/libretro/desmume"
KEYWORDS=""

LICENSE="GPL-2"
SLOT="0"

DEPEND=">=net-libs/libpcap-1.9.0"
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

S="${S}/desmume/src/frontend/libretro"
