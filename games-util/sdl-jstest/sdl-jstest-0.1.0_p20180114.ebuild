# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

COMMIT="34042f66c598957c1c05135e2619a44a5622a56e"

DESCRIPTION="SDL joystick testing tool"
HOMEPAGE="https://github.com/Grumbel/sdl-jstest"
SRC_URI="https://github.com/Grumbel/sdl-jstest/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
REQUIRED_USE=""
S="${WORKDIR}/${PN}-${COMMIT}"

RDEPEND="media-libs/libsdl[joystick]
media-libs/libsdl2[joystick,haptic]
sys-libs/ncurses"
DEPEND="${RDEPEND}
dev-util/cmake"
