# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils scons-utils git-r3

DESCRIPTION="A advanced, feature packed, multi-platform 2D and 3D game engine."
HOMEPAGE="http://www.godotengine.org"
SRC_URI=""

EGIT_REPO_URI="https://github.com/okamstudio/godot.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="+freetype llvm +openssl +png pulseaudio +vorbis +xml"

DEPEND=">=dev-util/scons-2.3.0"

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

USE_SCONS_TRUE=yes
USE_SCONS_FALSE=no

src_configure() {
	myesconsargs=(
		CC="$(tc-getCC)"
		builtin_zlib=no
		colored=yes
		platform=x11
		$(use_scons freetype)
		$(use_scons llvm use_llvm)
		$(use_scons openssl)
		$(use_scons png)
		$(use_scons pulseaudio)
		$(use_scons vorbis)
		$(use_scons xml)
	)
}

src_compile() {
	escons
}

src_install() {
	dobin bin/godot.*
	if [[ "${ARCH}" == "amd64" ]]; then
		if use llvm; then
			make_desktop_entry godot.x11.tools.64.llvm Godot
			with_desktop_entry=1
		else
			make_desktop_entry godot.x11.tools.64 Godot
			with_desktop_entry=1
		fi
	fi

	if [[ "${ARCH}" == "x86" ]]; then
		if use llvm; then
			make_desktop_entry godot.x11.tools.32.llvm Godot
			with_desktop_entry=1
		else
			make_desktop_entry godot.x11.tools.32 Godot
			with_desktop_entry=1
		fi
	fi

	if ! [[ "${with_desktop_entry}" == "1" ]]; then
		elog "Couldn't detect running architecture to create a desktop file."
	fi
}
