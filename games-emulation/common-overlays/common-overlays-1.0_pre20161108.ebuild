# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit libretro

DESCRIPTION="Collection of overlay files for use with libretro frontends."
HOMEPAGE="https://github.com/libretro/common-overlays"
SRC_URI="https://github.com/libretro/common-overlays/archive/5954c95a3209ece0619820fc11f4b6fb43f5a161.tar.gz -> ${P}.tar.gz"
RESTRICT="primaryuri"

S="${WORKDIR}/common-overlays-5954c95a3209ece0619820fc11f4b6fb43f5a161"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3

	EGIT_REPO_URI="git://github.com/libretro/common-overlays.git"
	KEYWORDS=""
else
	KEYWORDS="amd64 x86"
fi

LICENSE="GPL-3"
SLOT="0"

RDEPEND=""
DEPEND="${RDEPEND}"

src_install() {
	dodir "${LIBRETRO_DATA_DIR}"/overlays
	cp -R "${S}"/* "${D}${LIBRETRO_DATA_DIR}"/overlays
}
