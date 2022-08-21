# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_REPO_NAME="libretro/FBNeo"
inherit libretro-core

DESCRIPTION="Port of FinalBurn Neo to Libretro"
HOMEPAGE="https://github.com/libretro/FBNeo"
KEYWORDS=""

LICENSE="FBNeo"
SLOT="0"
IUSE="neon"

DEPEND=""
RDEPEND="${DEPEND}
	games-emulation/libretro-info"

S="${S}/src/burner/libretro"

pkg_preinst() {
	if ! has_version "=${CATEGORY}/${PN}-${PVR}"; then
		first_install="1"
	fi
}

LIBRETRO_CORE_NAME=fbneo

src_compile() {
	myemakeargs=(
		$(usex neon "HAVE_NEON=1" "")
		$(usex arm "platform=armv" "")
		$(usex amd64 "USE_X64_DRC=1" "")
	)
	libretro-core_src_compile
}

pkg_postinst() {
	if [[ "${first_install}" == "1" ]]; then
		elog ""
		elog "You should put the following optional files in your 'system_directory/fbneo' folder:"
		elog "neogeo.zip (Neo Geo BIOS)"
		elog "neocdz.zip (Neo Geo CDZ System BIOS)"
		elog "decocass.zip (DECO Cassette System BIOS)"
		elog "isgsm.zip (ISG Selection Master Type 2006 System BIOS)"
		elog "midssio.zip (Midway SSIO Sound Board Internal ROM)"
		elog "nmk004.zip (NMK004 Internal ROM)"
		elog "pgm.zip (PGM System BIOS)"
		elog "skns.zip (Super Kaneko Nova System BIOS)"
		elog "ym2608.zip (YM2608 Internal ROM)"
		elog "cchip.zip (C-Chip Internal ROM)"
		elog ""
		ewarn ""
	fi
}
