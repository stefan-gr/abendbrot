# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit libretro-core

DESCRIPTION="libretro implementation of PrBoom. (Doom)"
HOMEPAGE="https://github.com/libretro/libretro-prboom"
SRC_URI="https://github.com/libretro/libretro-prboom/archive/d1479f09b911098b454e500dfe7e7897d531810e.tar.gz -> ${P}.tar.gz"
RESTRICT="primaryuri"

S="${WORKDIR}/libretro-prboom-d1479f09b911098b454e500dfe7e7897d531810e"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/libretro/libretro-prboom.git"
	KEYWORDS=""
else
	KEYWORDS="amd64 x86"
fi

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
