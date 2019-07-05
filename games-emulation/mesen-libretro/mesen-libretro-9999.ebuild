# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_REPO_NAME="SourMesen/${PN//-libretro}"
inherit libretro-core

DESCRIPTION="libretro implementation of Mesen. (Nintendo Entertainment System)"
HOMEPAGE="https://github.com/SourMesen/Mesen"
KEYWORDS=""

LICENSE="GPL-3"
SLOT="0"
IUSE="clang lto"

DEPEND="clang? ( sys-devel/clang )"
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

pkg_preinst() {
	if ! has_version "=${CATEGORY}/${PN}-${PVR}"; then
		first_install="1"
	fi
}

src_compile() {
	myemakeargs+=(
		$(usex x86 "MESENPLATFORM=x86" "")
		$(usex amd64 "MESENPLATFORM=x64" "")
		$(usex lto "LTO=true" "")
		$(usex clang "" "USE_GCC=true")
	)
	emake "${myemakeargs[@]}" -f makefile libretro
	if use amd64; then
		mv mesen_libretro.so/mesen_libretro.x64.so mesen_libretro.so
	else
		mv mesen_libretro.so/mesen_libretro.x86.so mesen_libretro.so
	fi
}

pkg_postinst() {
	if [[ "${first_install}" == "1" ]]; then
		ewarn ""
		ewarn "You need to have the following files in your 'system_directory' folder:"
		ewarn "disksys.rom (Famicom Disk System BIOS)"
		ewarn ""
		ewarn ""
	fi
}
