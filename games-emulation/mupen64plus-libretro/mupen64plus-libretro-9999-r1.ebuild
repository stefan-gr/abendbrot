# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit libretro-core

DESCRIPTION="libretro implementation of mupen64plus (Nintendo64)"
HOMEPAGE="https://github.com/libretro/mupen64plus-libretro"
SRC_URI=""

EGIT_REPO_URI="git://github.com/libretro/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="gles2"

DEPEND="media-libs/mesa:0=
		gles2? ( media-libs/mesa[gles2] )"
RDEPEND="${DEPEND}"

src_compile() {
	#this one could get some love from arm owners
	myemakeargs=(
		$(usex amd64 "WITH_DYNAREC=x86_64" "")
		$(usex x86 "WITH_DYNAREC=x86" "")
		$(usex arm "platform=rpi WITH_DYNAREC=arm" "")
		$(usex arm64 "platform=rpi WITH_DYNAREC=arm" "")
		$(usex gles2 "GLES=1" "")
	)
	emake "${myemakeargs[@]}" || die "emake failed"
}
