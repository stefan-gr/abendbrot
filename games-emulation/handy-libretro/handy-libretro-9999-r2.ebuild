# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

LIBRETRO_REPO_NAME="libretro/libretro-${PN//-libretro}"
inherit libretro-core

DESCRIPTION="libretro implementation of Handy. (Atari Lynx)"
HOMEPAGE="https://github.com/libretro/libretro-handy"
KEYWORDS=""

LICENSE="ZLIB"
SLOT="0"
IUSE="debug"

DEPEND="sys-libs/zlib"
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

src_compile() {
	filter-flags -O*
	emake $(usex debug "DEBUG=1" "") || die "emake failed"
}

pkg_preinst() {
	if ! has_version "=${CATEGORY}/${PN}-${PVR}"; then
		first_install="1"
	fi
}

pkg_postinst() {
	if [[ "${first_install}" == "1" ]]; then
		elog ""
		elog "You should put the following optional files in your 'system_directory' folder:"
		elog "lynxboot.img (Lynx Boot Image)"
		elog ""
		ewarn ""
	fi
}
