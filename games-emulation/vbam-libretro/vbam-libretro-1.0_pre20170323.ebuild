# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_COMMIT_SHA="1b82fc2d761f027567632692f787482d1e287ec2"
inherit libretro-core

DESCRIPTION="libretro implementation of VBA-M. (Game Boy Advance)"
HOMEPAGE="https://github.com/libretro/vbam-libretro"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-2"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

S="${S}/src/libretro"
