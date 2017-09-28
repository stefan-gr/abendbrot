# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_COMMIT_SHA="b7f5c82094e560493219b444a7a756b5052ee2d1"
inherit libretro-core

DESCRIPTION="libretro implementation of Meteor. (Game Boy Advance)"
HOMEPAGE="https://github.com/libretro/meteor-libretro"
KEYWORDS="amd64 x86"

LICENSE="GPL-3"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

S="${S}/libretro"
