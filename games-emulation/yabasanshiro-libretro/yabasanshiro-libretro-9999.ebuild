# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_REPO_NAME="libretro/yabause"
EGIT_BRANCH="yabasanshiro"
inherit libretro-core

DESCRIPTION="libretro implementation of YabaSanshiro. (Sega Saturn)"
HOMEPAGE="http://www.uoyabause.org/"
KEYWORDS=""

LICENSE="GPL-2"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
                games-emulation/libretro-info"

S="${S}/yabause/src/libretro"

pkg_preinst() {
        if ! has_version "=${CATEGORY}/${PN}-${PVR}"; then
                first_install="1"
        fi
}

src_compile() {
        append-ldflags $(no-as-needed)
        emake CC=$(tc-getCC) CXX=$(tc-getCXX) LD=$(tc-getCXX) || die "emake failed"
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
