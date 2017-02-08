# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

LIBRETRO_COMMIT_SHA="1083de26495e7345387b3bde837243a07dd17689"
inherit libretro-core

DESCRIPTION="MAME2000 (0.37b5) for libretro."
HOMEPAGE="https://github.com/libretro/mame2000-libretro"
KEYWORDS="amd64 x86"

LICENSE="MAME-GPL"
SLOT="0"
IUSE="debug"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

src_compile() {
	filter-flags -O*
	emake $(usex debug "DEBUG=1" "") || die "emake failed"
}
