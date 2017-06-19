# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_REPO_NAME="libretro/${PN//-libretro}"
LIBRETRO_COMMIT_SHA="db18785aca846ac526e4c08555e2597afae1f444"
inherit libretro-core

DESCRIPTION="libretro implementation of redream. (SEGA Dreamcast)"
HOMEPAGE="https://github.com/libretro/redream"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-2"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

pkg_preinst() {
	if ! has_version "=${CATEGORY}/${PN}-${PVR}"; then
		first_install="1"
	fi
}

pkg_postinst() {
	if [[ "${first_install}" == "1" ]]; then
		ewarn ""
		ewarn "This core needs the following files in the \"'system_directory'/dc\" directory"
		ewarn "dc_boot.bin (Dreamcast BIOS), md5: e10c53c2f8b90bab96ead2d368858623"
		ewarn "dc_flash.bin (Date/Time/Language), md5: 0a93f7940c455905bea6e392dfde92a4"
		ewarn ""
	fi
}
