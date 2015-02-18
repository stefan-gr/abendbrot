# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit games git-2 cmake-utils

DESCRIPTION="Frontend for emulators"
HOMEPAGE="http://emulationstation.org/"
SRC_URI=""

EGIT_REPO_URI="https://github.com/Aloshi/EmulationStation.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="media-libs/libsdl2
	dev-cpp/eigen
	media-libs/freeimage[png,jpeg]
	dev-libs/boost
	media-libs/freetype
	net-misc/curl
	dev-util/cmake"

