# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_REPO_NAME="libretro/SameBoy"
LIBRETRO_COMMIT_SHA="8c9ff67b21c1b0b016e05052c117b8cda8c01b3d"
inherit libretro-core

DESCRIPTION="libretro implementation of SameBoy (Gameboy / Gameboy Color)"
HOMEPAGE="https://github.com/libretro/SameBoy"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-3"
SLOT="0"

DEPEND="dev-lang/rgbds"
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

S="${S}/libretro"

src_install() {
	LIBRETRO_CORE_LIB_FILE="${S}/../${LIBRETRO_CORE_NAME}_libretro.so"
	libretro-core_src_install
}

pkg_preinst() {
	if ! has_version "=${CATEGORY}/${PN}-${PVR}"; then
		first_install="1"
	fi
}

pkg_postinst() {
	if [[ "${first_install}" == "1" ]]; then
		elog ""
		elog "You can optionally place the following files in your 'system_directory' folder:"
		elog "dmg_boot.bin"
		elog "cgb_boot.bin"
		elog ""
	fi
}
