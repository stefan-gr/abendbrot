# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit libretro-core

DESCRIPTION="libretro implementation of Handy. (Atari Lynx)"
HOMEPAGE="https://github.com/libretro/libretro-handy"
SRC_URI=""

EGIT_REPO_URI="https://github.com/libretro/libretro-handy.git"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-libs/zlib"
DEPEND=""

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
		ewarn "This message will only be displayed once!"
		ewarn ""
	fi
}
