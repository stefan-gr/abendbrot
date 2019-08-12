# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils scons-utils

DESCRIPTION="A advanced, feature packed, multi-platform 2D and 3D game engine."
HOMEPAGE="http://www.godotengine.org"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/godotengine/godot.git"
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="https://github.com/godotengine/godot/archive/${PV}-stable.tar.gz -> ${P}.tar.gz"
	RESTRICT="primaryuri"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${PN}-${PV}-stable"
fi

LICENSE="MIT"
SLOT="0"
IUSE="+freetype llvm +openssl +png pulseaudio theora udev +vorbis +xml"

DEPEND="
		media-libs/alsa-lib
		media-libs/mesa[gles2]
		sys-libs/glibc
		sys-libs/zlib
		x11-libs/libX11
		x11-libs/libXcursor
		x11-libs/libXinerama
                x11-libs/libXi
                x11-libs/libXrandr
                x11-libs/libXrender
		freetype? ( media-libs/freetype:2 )
		llvm? ( sys-devel/llvm:=[clang(+)]
                       sys-devel/clang )
		png? ( media-libs/libpng )
		udev? ( virtual/udev )
		virtual/glu"

RDEPEND="${DEPEND}"

# Note there are a lot of bundled packages, some of which can enabled/disabled
# by the use flags, e.g. pulseaudio
src_configure() {
	MYSCONS=(
		CC="$(tc-getCC)"
		builtin_zlib=no
		colored=yes
		platform=x11
		freetype=$(usex freetype)
		openssl=$(usex openssl)
		png=$(usex png)
		pulseaudio=$(usex pulseaudio)
		theora=$(usex theora)
		udev=$(usex udev)
		use_llvm=$(usex llvm)
		vorbis=$(usex vorbis)
		xml=$(usex xml)
	)
}

src_compile() {
	escons "${MYSCONS[@]}"
}

src_install() {
	newicon icon.svg ${PN}.svg
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
