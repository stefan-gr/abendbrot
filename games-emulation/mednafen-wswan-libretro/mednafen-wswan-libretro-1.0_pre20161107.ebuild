# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

LIBRETRO_COMMIT_SHA="afbcd37760d51e2ea13de6c468ba4a5c8765e71e"
LIBRETRO_REPO_NAME="libretro/${PN/mednafen/beetle}"
inherit libretro-core

DESCRIPTION="libretro implementation of Mednafen Cygne. (WonderSwan/WonderSwan Color)"
HOMEPAGE="https://github.com/libretro/beetle-wswan-libretro"
KEYWORDS="amd64 x86"

LICENSE="GPL-2"
SLOT="0"
IUSE="debug"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

LIBRETRO_CORE_NAME=mednafen_wswan

src_compile() {
	filter-flags -O*
	emake $(usex debug "DEBUG=1" "") core=wswan || die "emake failed"
}
