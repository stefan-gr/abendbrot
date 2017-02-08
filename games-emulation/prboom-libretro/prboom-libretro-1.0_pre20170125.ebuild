# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

LIBRETRO_REPO_NAME="libretro/libretro-${PN//-libretro}"
LIBRETRO_COMMIT_SHA="63846591454d858388c4c20aec4ff8d38235aeee"
inherit libretro-core

DESCRIPTION="libretro implementation of PrBoom. (Doom)"
HOMEPAGE="https://github.com/libretro/libretro-prboom"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-2"
SLOT="0"
IUSE="debug"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

src_compile() {
	filter-flags -O*
	emake $(usex debug "DEBUG=1" "") || die "emake failed"
}

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
