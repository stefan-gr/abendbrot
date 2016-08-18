# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit libretro

DESCRIPTION="RetroArch joypad autoconfig files"
HOMEPAGE="https://github.com/libretro/retroarch-joypad-autoconfig/"
SRC_URI="https://github.com/libretro/retroarch-joypad-autoconfig/archive/06717ae4c5cb2e8eca56705118d90a44e30e8a3e.tar.gz -> ${P}.tar.gz"
RESTRICT="primaryuri"

S="${WORKDIR}/retroarch-joypad-autoconfig-06717ae4c5cb2e8eca56705118d90a44e30e8a3e"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="git://github.com/libretro/retroarch-joypad-autoconfig.git"
	KEYWORDS=""
else
	KEYWORDS="amd64 x86"
fi

LICENSE="GPL-3"
SLOT="0"

RDEPEND="virtual/udev"
DEPEND="${RDEPEND}"

src_install() {
	insinto "${RETROARCH_DATA_DIR}"/autoconfig
	doins "${S}"/udev/*.cfg
}
