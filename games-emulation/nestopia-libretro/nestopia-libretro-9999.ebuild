# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

DESCRIPTION="libretro implementation of NEStopia. (Nintendo Entertainment System)"
HOMEPAGE="https://github.com/libretro/nestopia"
SRC_URI=""

EGIT_REPO_URI="https://github.com/libretro/nestopia.git"

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

src_install() {
	insinto /usr/$(get_libdir)/libretro
	doins "${S}"/nestopia_libretro.so
	insinto /usr/share/libretro/info/
	doins "${WORKDIR}"/infos/dist/info/nestopia_libretro.info
}

pkg_postinst() {
	ewarn ""
	ewarn "This emulator needs a bios file in your 'system_directory'"
	ewarn "otherwise no game will not work. Please place it in the following directory:"
	ewarn "~/.local/share/retroarch/system/"
	ewarn ""
	ewarn "Here is a list with required files:"
	ewarn "disksys.rom (Famicom Disk System BIOS)"
	ewarn ""
}
