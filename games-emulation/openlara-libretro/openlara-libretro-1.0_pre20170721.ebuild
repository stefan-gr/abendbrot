# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_REPO_NAME="libretro/OpenLara"
LIBRETRO_COMMIT_SHA="0f1c2877b9f70c39ba61a4d4b7e259142213f2ce"
inherit libretro-core

DESCRIPTION="libretro implementation of OpenLara. (Classic Tomb Raider Engine)"
HOMEPAGE="https://github.com/libretro/OpenLara"
KEYWORDS="amd64 x86"

LICENSE="BSD-2"
SLOT="0"

IUSE="gles2"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

S="${S}/src/platform/libretro"

src_compile() {
	myemakeargs=(
		$(usex gles2 "GLES=1" "GLES=0")
	)
	libretro-core_src_compile
}
