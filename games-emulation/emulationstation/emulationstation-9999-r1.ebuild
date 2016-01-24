# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3 cmake-utils games

DESCRIPTION="Frontend for emulators"
HOMEPAGE="http://emulationstation.org/"
SRC_URI=""

EGIT_REPO_URI="git://github.com/Aloshi/EmulationStation.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE="themes"

COMMON_DEPEND="
	dev-cpp/eigen:3
	dev-libs/boost
	media-libs/freeimage[png,jpeg]
	media-libs/freetype
	media-libs/libsdl2
	net-misc/curl
"
RDEPEND="${COMMON_DEPEND}
	themes? ( games-emulation/emulationstation-themes )
"
DEPEND="${COMMON_DEPEND}
	dev-util/cmake
	virtual/pkgconfig
"

src_unpack() {
	git-r3_fetch
	git-r3_checkout
}

src_configure() {
	local mycmakeargs=(
		"-DCMAKE_INSTALL_PREFIX=${GAMES_PREFIX}"
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
	prepgamesdirs
}
