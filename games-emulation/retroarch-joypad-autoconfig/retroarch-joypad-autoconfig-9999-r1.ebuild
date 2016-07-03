# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit libretro git-r3

DESCRIPTION="RetroArch joypad autoconfig files"
HOMEPAGE="https://github.com/libretro/retroarch-joypad-autoconfig/"
SRC_URI=""

EGIT_REPO_URI="git://github.com/libretro/retroarch-joypad-autoconfig.git"
if [[ ${PV} == 9999 ]]; then
	KEYWORDS=""
else
	EGIT_COMMIT_DATE="${PV:7:4}-${PV:11:2}-${PV:13:2}"
	KEYWORDS="amd64 x86"
fi

LICENSE="GPL-3"
SLOT="0"

RDEPEND="virtual/udev"
DEPEND="${RDEPEND}"

src_install() {
	insinto "${RETROARCH_DATA_DIR}"/autoconfig
	doins "${S}"/udev/*.cfg
	prepgamesdirs
}
