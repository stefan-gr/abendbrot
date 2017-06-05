# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit libretro-core

DESCRIPTION="Bomberman clone for RetroArch platform"
HOMEPAGE="https://github.com/libretro/mrboom-libretro"
KEYWORDS=""

LICENSE="GPL-2"
SLOT="0"
IUSE="debug"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

src_compile() {
	#this one could get some love from arm owners
	filter-flags -O*
	myemakeargs=(
	)
	emake "${myemakeargs[@]}" || die "emake failed"
}
