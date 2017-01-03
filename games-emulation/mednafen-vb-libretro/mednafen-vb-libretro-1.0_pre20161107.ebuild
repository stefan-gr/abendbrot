# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

LIBRETRO_COMMIT_SHA="c99ba93ff1e1024b3034fb9e069864b2b93a0bda"
LIBRETRO_REPO_NAME="libretro/${PN/mednafen/beetle}"
inherit libretro-core

DESCRIPTION="libretro implementation of Mednafen VB. (Virtual Boy)"
HOMEPAGE="https://github.com/libretro/beetle-vb-libretro"
KEYWORDS="amd64 x86"

LICENSE="GPL-2"
SLOT="0"
IUSE="debug"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

LIBRETRO_CORE_NAME=mednafen_vb

src_compile() {
	filter-flags -O*
	emake $(usex debug "DEBUG=1" "") core=vb || die "emake failed"
}
