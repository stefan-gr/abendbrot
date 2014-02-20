# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{3_1,3_2,3_3} )

inherit games python-single-r1 git-2 flag-o-matic

DESCRIPTION="Universal frontend for libretro-based emulators"
HOMEPAGE="http://www.libretro.com/"
SRC_URI=""

EGIT_REPO_URI="git://github.com/libretro/RetroArch.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="alsa cg +fbo ffmpeg jack netplay openal oss pulseaudio python sdl sdl-image truetype udev xml xv zlib"

RDEPEND="sdl? ( >=media-libs/libsdl-1.2.10[joystick] )
	alsa? ( media-libs/alsa-lib )
	cg? ( media-gfx/nvidia-cg-toolkit )
	ffmpeg? ( virtual/ffmpeg )
	jack? ( >=media-sound/jack-audio-connection-kit-0.120.1 )
	openal? ( media-libs/openal )
	xml? ( dev-libs/libxml2 )
	truetype? ( media-libs/freetype:2 )
	pulseaudio? ( media-sound/pulseaudio )
	sdl-image? ( media-libs/sdl-image )
	xv? ( x11-libs/libXv )
	zlib? ( sys-libs/zlib )
	python? ( ${PYTHON_DEPS} )
	udev? ( >=x11-libs/libxkbcommon-0.4.0 )"
DEPEND="virtual/pkgconfig
	${RDEPEND}"

REQUIRED_USE="|| ( alsa jack openal oss pulseaudio )"

pkg_setup() {
	use python && python-single-r1_pkg_setup
	games_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}/${P}-build.patch" \
		"${FILESDIR}/${PN}-python.patch" \

	if use python; then
		sed -i qb/config.libs.sh \
			-e "s:%PYTHON_VER%:${EPYTHON/python/}:" \
			|| die
	fi
}

src_configure() {
	if use cg; then
		append-ldflags -L/opt/nvidia-cg-toolkit/$(get_libdir)
		append-cflags -I/opt/nvidia-cg-toolkit/include
	fi
	egamesconf \
		$(use_enable alsa) \
		$(use_enable ffmpeg) \
		$(use_enable jack) \
		$(use_enable openal al) \
		$(use_enable oss) \
		$(use_enable cg) \
		$(use_enable xml libxml2) \
		$(use_enable fbo) \
		$(use_enable truetype freetype) \
		$(use_enable pulseaudio pulse) \
		$(use_enable netplay) \
		$(use_enable sdl-image sdl_image) \
		$(use_enable xv xvideo) \
		$(use_enable python) \
		$(use_enable zlib) \
		$(use_enable sdl) \
		$(use_enable udev) \
		--enable-dynamic \
		--with-man_dir="/usr/share/man/man1" \
		|| die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README.md AUTHORS
	prepgamesdirs
}
