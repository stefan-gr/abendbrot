# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

DESCRIPTION="libretro implementation of PrBoom. (Doom)"
HOMEPAGE="https://github.com/libretro/libretro-prboom"
SRC_URI=""

EGIT_REPO_URI="https://github.com/libretro/libretro-prboom.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=""
DEPEND=""

src_unpack() {
	git-r3_fetch https://github.com/libretro/libretro-super.git HEAD
	git-r3_checkout https://github.com/libretro/libretro-super.git \
		"${WORKDIR}"/infos
	git-r3_fetch
	git-r3_checkout
}

src_install() {
	insinto /usr/$(get_libdir)/libretro
	doins "${S}"/prboom_libretro.so
	insinto /usr/share/libretro/info/
	doins "${WORKDIR}"/infos/dist/info/prboom_libretro.info
	insinto /usr/share/libretro/prboom_libretro/
	doins "${S}"/prboom.wad
}

pkg_preinst() {
	if ! has_version "=${CATEGORY}/${PN}-${PV}"; then
		first_install="1"
	fi
}

pkg_postinst() {
	if [[ "${first_install}" == "1" ]]; then
		elog ""
		elog "You need to copy the \"prboom.wad\" file from \"/usr/share/libretro/prboom_libretro/\""
		elog "into the retroarch \"rgui_browser_directory\" folder of your user."
		elog ""
		elog "\$ cp -r /usr/share/libretro/prboom_libretro/prboom.wad ~/"
		elog ""
		ewarn "This message will only be displayed once!"
		ewarn ""
	fi
}
