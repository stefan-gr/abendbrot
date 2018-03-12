# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_REPO_NAME="libretro/SameBoy"
LIBRETRO_COMMIT_SHA="84a4a3c2cced1768f21e717b5b4c07334fd0534a"
inherit libretro-core

DESCRIPTION="libretro implementation of SameBoy (Gameboy / Gameboy Color)"
HOMEPAGE="https://github.com/libretro/SameBoy"
KEYWORDS="amd64 x86"

LICENSE="GPL-3"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

src_prepare() {
    # Disable -Werror
    sed 's/-Werror //' -i Makefile
    libretro-core_src_prepare
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
