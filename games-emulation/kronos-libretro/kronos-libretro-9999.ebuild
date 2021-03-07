# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_REPO_NAME="libretro/yabause"
EGIT_BRANCH="kronos"
inherit libretro-core

DESCRIPTION="libretro implementation of Kronos. (Sega - Saturn/ST-V)"
HOMEPAGE="https://github.com/FCare/Kronos"
KEYWORDS=""

LICENSE="GPL-2"
SLOT="0"
IUSE="gles3"

DEPEND=""
RDEPEND="${DEPEND}
	games-emulation/libretro-info"

S="${S}/yabause/src/libretro"

pkg_preinst() {
	if ! has_version "=${CATEGORY}/${PN}-${PVR}"; then
		first_install="1"
	fi
}

src_compile() {
	myemakeargs=(
		$(usex gles3 "FORCE_GLES=1" "")
		$(usex arm "HAVE_SSE=0" "")
		$(usex arm64 "HAVE_SSE=0" "")
	)
	libretro-core_src_compile
}

pkg_postinst() {
	if [[ "${first_install}" == "1" ]]; then
		elog ""
		elog "You should put the following optional files in your 'system_directory/kronos' folder:"
		elog "saturn_bios.bin (Saturn BIOS)"
		elog "stvbios.zip (ST-V BIOS)"
		elog ""
		elog "Additionally you should put the following optional files in your 'system_directory' folder:"
		elog "mpr-18811-mx.ic1 (The King of Fighters '95 ROM Cartridge)"
		elog "mpr-19367-mx.ic1 (Ultraman: Hikari no Kyojin Densetsu ROM Cartridge)"
		ewarn ""
	fi
}
