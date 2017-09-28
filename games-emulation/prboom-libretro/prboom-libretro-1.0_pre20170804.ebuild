# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_REPO_NAME="libretro/libretro-${PN//-libretro}"
LIBRETRO_COMMIT_SHA="d2532ad1e10b1907d17dd3e18fb622627eb8909d"
inherit libretro-core

DESCRIPTION="libretro implementation of PrBoom. (Doom)"
HOMEPAGE="https://github.com/libretro/libretro-prboom"
KEYWORDS="amd64 x86"

LICENSE="GPL-2"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

src_install() {
	insinto "${LIBRETRO_DATA_DIR}"/prboom_libretro/
	doins "${S}"/prboom.wad
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
		elog "You need to copy the \"prboom.wad\" file from \"${LIBRETRO_DATA_DIR}/prboom_libretro/\""
		elog "into the retroarch \"rgui_browser_directory\" folder of your user."
		elog ""
		elog "\$ cp -r ${LIBRETRO_DATA_DIR}/prboom_libretro/prboom.wad ~/"
		elog ""
		ewarn ""
	fi
}
