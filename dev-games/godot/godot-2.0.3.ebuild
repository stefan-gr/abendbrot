# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils scons-utils

DESCRIPTION="A advanced, feature packed, multi-platform 2D and 3D game engine."
HOMEPAGE="http://www.godotengine.org"
SRC_URI="https://github.com/godotengine/godot/archive/${PV}-stable.tar.gz -> ${P}.tar.gz"
RESTRICT="primaryuri"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+freetype llvm +openssl +png pulseaudio +vorbis +xml icon"

DEPEND=">=dev-util/scons-2.3.0
		icon? ( media-gfx/imagemagick )"

RDEPEND="
	>=app-arch/bzip2-1.0.6-r6
	>=app-arch/lz4-0_p120
	>=app-arch/xz-utils-5.0.8
	xml? ( >=dev-libs/expat-2.1.0-r3 )
	>=dev-libs/json-c-0.11-r1
	freetype? ( >=media-libs/freetype-2.5.3-r1:2 )
	>=media-libs/alsa-lib-1.0.28
	>=media-libs/flac-1.3.1-r1
	>=media-libs/libogg-1.3.1
	>=media-libs/libsndfile-1.0.25-r1
	>=media-libs/mesa-10.2.8[gles2]
	pulseaudio? ( >=media-sound/pulseaudio-5.0-r7 )
	>=net-libs/libasyncns-0.8-r3
	openssl? ( >=dev-libs/openssl-1.0.1j:0 )
	png? ( >=media-libs/libpng-1.6.16:0 )
	>=sys-apps/attr-2.4.47-r1
	>=sys-apps/tcp-wrappers-7.6.22-r1
	>=sys-apps/util-linux-2.25.2-r2
	>=sys-devel/gcc-4.6.4[cxx]
	llvm? ( >=sys-devel/llvm-3.6.0[clang] )
	>=sys-libs/gdbm-1.11
	>=sys-libs/glibc-2.20-r2
	>=sys-libs/glibc-2.20-r2
	>=sys-libs/libcap-2.22-r2
	>=sys-libs/zlib-1.2.8-r1
	virtual/glu
	vorbis? ( >=media-libs/libvorbis-1.3.4 )
	>=x11-libs/libICE-1.0.9
	>=x11-libs/libSM-1.2.2-r1
	>=x11-libs/libX11-1.6.2
	>=x11-libs/libXau-1.0.8
	>=x11-libs/libXcursor-1.1.14
	>=x11-libs/libXdamage-1.1.4-r1
	>=x11-libs/libXdmcp-1.1.1-r1
	>=x11-libs/libXext-1.3.3
	>=x11-libs/libXfixes-5.0.1
	>=x11-libs/libXinerama-1.1.3
	>=x11-libs/libXrender-0.9.8
	>=x11-libs/libXtst-1.2.2
	>=x11-libs/libXxf86vm-1.1.4
	>=x11-libs/libdrm-2.4.59
	>=x11-libs/libxcb-1.11-r1
	>=x11-libs/libxshmfence-1.2
	"

S="${WORKDIR}/${PN}-${PV}-stable"

src_configure() {
	MYSCONS=(
		CC="$(tc-getCC)"
		builtin_zlib=no
		colored=yes
		platform=x11
		freetype=$(usex freetype)
		use_llvm=$(usex llvm)
		openssl=$(usex openssl)
		png=$(usex png)
		pulseaudio=$(usex pulseaudio)
		vorbis=$(usex vorbis)
		xml=$(usex xml)
	)
}

src_compile() {
	escons "${MYSCONS[@]}"
}

src_install() {
	if use icon ; then
		APPICON=godot
		convert logo.png -gravity East -chop 118x0 -scale 64x64 ${APPICON}.png
		doicon --size 64 ${APPICON}.png
	fi

	dobin bin/godot.*
	if [[ "${ARCH}" == "amd64" ]]; then
		if use llvm; then
			make_desktop_entry godot.x11.tools.64.llvm Godot ${APPICON}
			with_desktop_entry=1
		else
			make_desktop_entry godot.x11.tools.64 Godot ${APPICON}
			with_desktop_entry=1
		fi
	fi

	if [[ "${ARCH}" == "x86" ]]; then
		if use llvm; then
			make_desktop_entry godot.x11.tools.32.llvm Godot ${APPICON}
			with_desktop_entry=1
		else
			make_desktop_entry godot.x11.tools.32 Godot ${APPICON}
			with_desktop_entry=1
		fi
	fi

	if ! [[ "${with_desktop_entry}" == "1" ]]; then
		elog "Couldn't detect running architecture to create a desktop file."
	fi
}
