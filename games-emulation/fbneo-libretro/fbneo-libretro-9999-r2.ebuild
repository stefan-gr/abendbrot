# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_REPO_NAME="libretro/FBNeo"
inherit libretro-core

DESCRIPTION="Port of FinalBurn Neo to Libretro"
HOMEPAGE="https://github.com/libretro/FBNeo"
KEYWORDS=""

LICENSE="FBNeo"
SLOT="0"
IUSE="neon"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

S="${S}/src/burner/libretro"

LIBRETRO_CORE_NAME=fbneo

src_compile() {
	myemakeargs=(
		$(usex neon "HAVE_NEON=1" "")
		$(usex arm "platform=armv" "")
		$(usex amd64 "USE_X64_DRC=1" "")
	)
	libretro-core_src_compile
}
