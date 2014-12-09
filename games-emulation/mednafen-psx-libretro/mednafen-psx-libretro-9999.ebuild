# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

DESCRIPTION="libretro implementation of Mednafen PSX. (PlayStation, original fork)"
HOMEPAGE="https://github.com/libretro/mednafen-psx-libretro"
SRC_URI=""

EGIT_REPO_URI="https://github.com/libretro/mednafen-psx-libretro.git"

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

src_compile() {
	emake core=psx || die "emake failed"
}

src_install() {
	insinto /usr/$(get_libdir)/libretro
	doins "${S}"/mednafen_psx_libretro.so
	insinto /usr/share/libretro/info/
	doins "${WORKDIR}"/infos/dist/info/mednafen_psx_libretro.info
}

pkg_postinst() {
	ewarn ""
	ewarn "You need to have original PlayStation bios files in your 'system_directory'"
	ewarn "otherwise no game will work. Please place them in the following directory:"
	ewarn "~/.local/share/retroarch/system/"
	ewarn ""
	ewarn "Here is a list with required files and md5sums:"
	ewarn "scph5500.bin = 8dd7d5296a650fac7319bce665a6a53c"
	ewarn "scph5501.bin = 490f666e1afb15b7362b406ed1cea246"
	ewarn "scph5502.bin = 32736f17079d0b2b7024407c39bd3050"
	ewarn ""
}
