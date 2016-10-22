# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit libretro-core

DESCRIPTION="libretro implementation of Handy. (Atari Lynx)"
HOMEPAGE="https://github.com/libretro/libretro-handy"
SRC_URI="https://github.com/libretro/libretro-handy/archive/dda69e5ba38c9944a4cbb7fb320088d80c102813.tar.gz -> ${P}.tar.gz"
RESTRICT="primaryuri"

S="${WORKDIR}/libretro-handy-dda69e5ba38c9944a4cbb7fb320088d80c102813"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/libretro/libretro-handy.git"
	KEYWORDS=""
else
	KEYWORDS="amd64 x86"
fi

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
