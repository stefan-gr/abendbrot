# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit libretro-core

DESCRIPTION="libretro implementation of mupen64plus with vulkan support (Nintendo 64)"
HOMEPAGE="https://github.com/libretro/mupen64plus-libretro"
SRC_URI="https://github.com/libretro/mupen64plus-libretro/archive/cb5f983eeed8a82c4e48cbda07cdb929b9a1f74c.tar.gz -> ${P}.tar.gz"
RESTRICT="primaryuri"

S="${WORKDIR}/mupen64plus-libretro-cb5f983eeed8a82c4e48cbda07cdb929b9a1f74c"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="git://github.com/libretro/mupen64plus-libretro.git"
	KEYWORDS=""
else
	KEYWORDS="amd64 x86"
fi

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
		$(usex amd64 "WITH_DYNAREC=x86_64" "")
		$(usex x86 "WITH_DYNAREC=x86" "")
		$(usex arm "platform=rpi WITH_DYNAREC=arm" "")
		$(usex arm64 "platform=rpi WITH_DYNAREC=arm" "")
		$(usex debug "DEBUG=1" "")
		"HAVE_VULKAN=1"
	)
	emake "${myemakeargs[@]}" || die "emake failed"
}
