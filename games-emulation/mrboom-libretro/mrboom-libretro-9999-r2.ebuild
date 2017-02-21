# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit libretro-core

DESCRIPTION="Multiplayer Bomberman clone for RetroArch/Libretro"
HOMEPAGE="https://github.com/libretro/mrboom-libretro"
KEYWORDS=""

LICENSE="MIT"
SLOT="0"
IUSE="debug"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

src_compile() {
	filter-flags -O*
	emake $(usex debug "DEBUG=1" "") || die "emake failed"
}

#src_install() {
#	insinto "${LIBRETRO_DATA_DIR}"/${PN}
#	libretro-core_src_install
#}
