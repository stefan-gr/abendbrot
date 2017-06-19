# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_REPO_NAME="libretro/${PN//-libretro}"
LIBRETRO_COMMIT_SHA="a6ad451fdd4ac8753fd1a8e2234ec34674677754"
inherit libretro-core

DESCRIPTION="libretro implementation of Dolphin. (Nintendo GC/Wii)"
HOMEPAGE="https://github.com/libretro/dolphin"
KEYWORDS="amd64 x86"

LICENSE="GPL-2"
SLOT="0"
IUSE="opengl vulkan"

DEPEND="opengl? ( virtual/opengl )
	vulkan? ( media-libs/vulkan-loader:0= )"
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

S="${S}"/Source/Core/DolphinLibretro

src_compile() {
	myemakeargs=(
		$(usex opengl "HAVE_OPENGL_CORE=1" "HAVE_OPENGL_CORE=0")
		$(usex vulkan "HAVE_VULKAN=1" "HAVE_VULKAN=0")
		STATIC_LINKING=0
	)
	libretro-core_src_compile
}
