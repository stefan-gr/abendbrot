# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_REPO_NAME="libretro/yabause"
EGIT_BRANCH="yabasanshiro"
inherit libretro-core

DESCRIPTION="libretro implementation of YabaSanshiro. (Sega Saturn)"
HOMEPAGE="http://www.uoyabause.org/"
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
		$(usex arm "platform=armv" "")
	)
	libretro-core_src_compile
}

pkg_postinst() {
	if [[ "${first_install}" == "1" ]]; then
		elog ""
		elog "You should put the following optional files in your 'system_directory' folder:"
		elog "saturn_bios.bin (Saturn BIOS)"
		elog ""
		ewarn ""
	fi
}
