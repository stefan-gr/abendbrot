# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit libretro-core

DESCRIPTION="libretro implementation of Yabause. (Sega Saturn)"
HOMEPAGE="https://github.com/libretro/yabause"
SRC_URI="https://github.com/libretro/yabause/archive/3500395bc9459d5101e494cfd8d8d8653aa1858e.tar.gz -> ${P}.tar.gz"
RESTRICT="primaryuri"

S="${WORKDIR}/yabause-3500395bc9459d5101e494cfd8d8d8653aa1858e"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/libretro/yabause.git"
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

S="${S}/libretro"

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
		elog "saturn_bios.bin (Saturn BIOS)"
		elog ""
		ewarn ""
	fi
}
