# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

DESCRIPTION="libretro implementation of Yabause. (Sega Saturn)"
HOMEPAGE="https://github.com/libretro/yabause"
SRC_URI=""

EGIT_REPO_URI="https://github.com/libretro/yabause.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=""
DEPEND=""

S="${S}/libretro"

src_unpack() {
	git-r3_fetch https://github.com/libretro/libretro-super.git HEAD
	git-r3_checkout https://github.com/libretro/libretro-super.git \
		"${WORKDIR}"/infos
	git-r3_fetch
	git-r3_checkout
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	insinto /usr/$(get_libdir)/libretro
	doins "${S}"/yabause_libretro.so
	insinto /usr/share/libretro/info/
	doins "${WORKDIR}"/infos/dist/info/yabause_libretro.info
}

pkg_postinst() {
	elog ""
	elog "You can use the original Saturn bios files in your 'system_directory'"
	elog "to make it more compatible. Please place them in the following directory:"
	elog "~/.local/share/retroarch/system/"
	elog ""
	elog "Here is a list with optional files:"
	elog "saturn_bios.bin (Saturn BIOS)"
	elog ""
}
