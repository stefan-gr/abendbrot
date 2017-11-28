# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_REPO_NAME="libretro/Craft"
LIBRETRO_COMMIT_SHA="2c6c6cfd9957f7af33a609610d6f0766d157fda8"
inherit libretro-core

DESCRIPTION="libretro implementation of Craft. (Minecraft clone)"
HOMEPAGE="https://github.com/libretro/Craft"
KEYWORDS="amd64 x86"

LICENSE="Craft"
SLOT="0"
IUSE="gles2"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

src_compile() {
	myemakeargs=(
		$(usex gles2 "GLES=1" "GLES=0")
	)
	libretro-core_src_compile
}

src_install() {
	insinto "${LIBRETRO_DATA_DIR}"/${PN}
	doins "${S}"/LICENSE.md
	libretro-core_src_install
}
