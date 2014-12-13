# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

DESCRIPTION="libretro implementation of PicoDrive. \
(Sega GameGear/Sega CD/32X)"
HOMEPAGE="https://github.com/libretro/picodrive"
SRC_URI=""

EGIT_REPO_URI="https://github.com/libretro/picodrive.git"

LICENSE="PD"
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

src_configure() {
	./configure
}

src_compile() {
	make -f Makefile.libretro || die "emake failed!"
}

src_install() {
	insinto /usr/$(get_libdir)/libretro
	doins "${S}"/picodrive_libretro.so
	insinto /usr/share/libretro/info/
	doins "${WORKDIR}"/infos/dist/info/picodrive_libretro.info
	insinto /usr/share/libretro/picodrive_libretro
	doins "${S}"/COPYING
}

pkg_postinst() {
	ewarn ""
	ewarn "You need to have the following files in your 'system_directory' folder:"
	ewarn "bios_CD_E.bin (MegaCD EU BIOS)"
	ewarn "bios_CD_U.bin (SegaCD US BIOS)"
	ewarn "bios_CD_J.bin (MegaCD JP BIOS)"
	ewarn ""
}
