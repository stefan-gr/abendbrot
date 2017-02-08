# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

LIBRETRO_COMMIT_SHA="b486bcaa32f84ddff73de43820ae350a4bbd06da"
inherit libretro-core

DESCRIPTION="libretro implementation of mupen64plus (Nintendo64)"
HOMEPAGE="https://github.com/libretro/mupen64plus-libretro"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-2"
SLOT="0"
IUSE="debug gles2 vulkan"

DEPEND="media-libs/mesa:0=
		gles2? ( media-libs/mesa[gles2] )"
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

src_compile() {
	#this one could get some love from arm owners
	filter-flags -O*
	myemakeargs=(
		$(usex amd64 "WITH_DYNAREC=x86_64" "")
		$(usex x86 "WITH_DYNAREC=x86" "")
		$(usex arm "platform=rpi WITH_DYNAREC=arm" "")
		$(usex arm64 "platform=rpi WITH_DYNAREC=arm" "")
		$(usex debug "DEBUG=1" "DEBUG=0")
		$(usex gles2 "FORCE_GLES=1" "FORCE_GLES=0")
		$(usex vulkan "HAVE_PARALLEL=1" "HAVE_PARALLEL=0")
	)
	emake "${myemakeargs[@]}" || die "emake failed"
}
