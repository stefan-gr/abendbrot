# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_REPO_NAME="SourMesen/Mesen-S"
inherit libretro-core

DESCRIPTION="libretro implementation of Mesen-S. (Super Nintendo Entertainment System)"
HOMEPAGE="https://github.com/SourMesen/Mesen-S"
KEYWORDS=""

LICENSE="GPL-3"
SLOT="0"
IUSE="+clang +lto"

DEPEND="clang? ( sys-devel/clang )"
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

LIBRETRO_CORE_NAME=mesen_s

src_compile() {
	myemakeargs+=(
		$(usex x86 "MESENPLATFORM=x86" "")
		$(usex amd64 "MESENPLATFORM=x64" "")
		$(usex lto "LTO=true" "")
		$(usex clang "" "USE_GCC=true")
	)
	emake "${myemakeargs[@]}" -f makefile libretro
	if use amd64; then
		mv bin/mesen-s_libretro.x64.so mesen_s_libretro.so
	else
		mv bin/mesen-s_libretro.x86.so mesen_s_libretro.so
	fi
}
