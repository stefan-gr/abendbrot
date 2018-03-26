# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_REPO_NAME="libretro/${PN//-libretro}"
LIBRETRO_COMMIT_SHA="dbbe316c5617a4608dcab4a568fb090b207aa21a"
inherit libretro-core

DESCRIPTION="libretro implementation of PPSSPP. (PlayStation Portable/PSP)"
HOMEPAGE="https://github.com/libretro/ppsspp"
KEYWORDS="~amd64 ~x86 ~arm"

LICENSE="GPL-2"
SLOT="0"
IUSE="gles2"

DEPEND="x11-libs/libICE
	sys-libs/zlib
	x11-libs/libXt
	x11-libs/libXext
	media-libs/mesa
	gles2? ( media-libs/mesa[gles2] )
	gles2? ( dev-libs/wayland )
	!games-emulation/psp-assets"
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

S=${S}/libretro

ASSETS_DIR=${LIBRETRO_DATA_DIR}/PPSSPP

src_prepare() {
	libretro-core_src_prepare
	#fixing ARCH detection
	sed -i Makefile \
		-e 's:$(ARCH):$(REAL_ARCH):' \
		-e 's:ARCH = $(shell uname -m):REAL_ARCH = $(shell uname -m):' \
		|| die '"sed" failed'
	sed -i Makefile.common \
		-e 's:ifeq ($(WITH_DYNAREC), arm):ifneq (,$(findstring arm,$(WITH_DYNAREC))):' \
		|| die '"sed" failed'
}

src_compile() {
	use gles2 && append-ldflags -lEGL
	myemakeargs=(
		$(usex gles2 "GLES=1" "")
	)
	libretro-core_src_compile
}

src_install() {
	dodir ${ASSETS_DIR}
	cp -R "${S}"/../assets/* "${D}${ASSETS_DIR}" || die "Install failed!"
	libretro-core_src_install
}

pkg_postinst() {
	ewarn ""
	ewarn "You need to symlink \"${ASSETS_DIR}\""
	ewarn "to the \"system_directory/\" directory of your user."
	ewarn "As retroarch user:"
	ewarn "When upgrading from old assets:"
	ewarn "\$ rm -r ~/.local/share/retroarch/system/PPSSPP/"
	ewarn "To symlink the assets:"
	ewarn "\$ mkdir -p ~/.local/share/retroarch/system"
	ewarn "\$ ln -s ${ASSETS_DIR} ~/.local/share/retroarch/system/"
	ewarn ""
	ewarn ""
}
