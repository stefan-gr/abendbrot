# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

LIBRETRO_REPO_NAME="libretro/${PN/mednafen/beetle}"
LIBRETRO_COMMIT_SHA="20f9a62df2f11d365b1c2154a95a1be7853bbd0c"
inherit libretro-core

DESCRIPTION="libretro implementation of Mednafen Cygne. (WonderSwan/WonderSwan Color)"
HOMEPAGE="https://github.com/libretro/beetle-wswan-libretro"
KEYWORDS="~amd64 ~x86"

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
