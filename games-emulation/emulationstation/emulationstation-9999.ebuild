# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3 cmake-utils games

DESCRIPTION="Frontend for emulators"
HOMEPAGE="http://emulationstation.org/"
SRC_URI=""

EGIT_REPO_URI="git://github.com/Aloshi/EmulationStation.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE=""

RDEPEND="media-libs/libsdl2
	dev-cpp/eigen
	media-libs/freeimage[png,jpeg]
	dev-libs/boost
	media-libs/freetype
	net-misc/curl
	dev-util/cmake"
DEPEND="virtual/pkgconfig
        ${RDEPEND}"

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
