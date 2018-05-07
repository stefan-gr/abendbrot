# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="RPG Maker 2000/2003 and EasyRPG games interpreter"
HOMEPAGE="https://easyrpg.org/player/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/EasyRPG/Player.git"
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="https://github.com/EasyRPG/Player/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 x86"
	S="${WORKDIR}/Player-${PV}"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="dev-libs/liblcf:0=
	media-libs/libsdl2:0=
	media-libs/sdl2-mixer:0=
	x11-libs/pixman:0=
	media-libs/libpng:0=
	sys-libs/zlib:0=
	media-libs/freetype:2=
	media-libs/harfbuzz:0=
	media-sound/mpg123:0=
	media-sound/wildmidi:0=
	media-libs/libvorbis:0=
	media-libs/libsndfile:0=
	media-libs/speex:0="
RDEPEND="${DEPEND}"

src_prepare() {
	default_src_prepare
	eautoreconf
}
