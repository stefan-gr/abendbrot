# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_COMMIT_SHA="a6fb2f092148a6087c3d7d6af0ee3b28000530fd"
inherit libretro

DESCRIPTION="RetroArch joypad autoconfig files"
HOMEPAGE="https://github.com/libretro/retroarch-joypad-autoconfig"
KEYWORDS="amd64 x86"

LICENSE="GPL-3"
SLOT="0"

RDEPEND="virtual/udev"
DEPEND="${RDEPEND}"

src_install() {
	insinto "${RETROARCH_DATA_DIR}"/autoconfig
	doins "${S}"/udev/*.cfg
}
