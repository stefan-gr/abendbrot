# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{3_2,3_3,3_4} )

inherit games python-single-r1 git-r3 flag-o-matic

DESCRIPTION="Universal frontend for libretro-based emulators"
HOMEPAGE="http://www.libretro.com/"
SRC_URI=""

EGIT_REPO_URI="git://github.com/libretro/RetroArch.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa +autoconfig +cg +cores egl +fbo ffmpeg gles gles3 glui jack kms lakka +netplay openal +opengl oss pulseaudio python sdl sdl2 +truetype +threads +udev v4l2 openvg xml xmb xv xinerama +x11 zlib"

RDEPEND="alsa? ( media-libs/alsa-lib )
	cg? ( media-gfx/nvidia-cg-toolkit )
	cores? ( games-emulation/libretro-meta )
	egl? ( media-libs/mesa[egl] )
	ffmpeg? ( >=media-video/ffmpeg-2.1.3 )
	gles? ( media-libs/mesa[gles2] )
	jack? ( >=media-sound/jack-audio-connection-kit-0.120.1 )
	openal? ( media-libs/openal )
	opengl? ( media-libs/mesa )
	openvg? ( media-libs/mesa[openvg] )
	pulseaudio? ( media-sound/pulseaudio )
	python? ( ${PYTHON_DEPS} )
	sdl2? ( media-libs/libsdl2[joystick] )
	sdl? ( >=media-libs/libsdl-1.2.10[joystick] )
	truetype? ( media-libs/freetype:2 )
	udev? ( >=x11-libs/libxkbcommon-0.4.0
	v4l2? ( media-libs/libv4l )
	virtual/udev
	x11-drivers/xf86-input-evdev )
	x11? ( x11-base/xorg-server )
	xinerama? ( x11-libs/libXinerama )
	xml? ( dev-libs/libxml2 )
	xv? ( x11-libs/libXv )
	zlib? ( sys-libs/zlib )"
DEPEND="virtual/pkgconfig
	${RDEPEND}"

REQUIRED_USE="|| ( alsa jack openal oss pulseaudio )
	      || ( opengl sdl sdl2 )
	      alsa? ( threads )
	      autoconfig? ( udev )
	      cg? ( opengl )
	      egl? ( x11 )
	      opengl? ( !gles )
	      sdl2? ( !sdl )
	      xinerama? ( x11 )
	      xv? ( x11 )"

pkg_setup() {
	use python && python-single-r1_pkg_setup
	games_pkg_setup
}

src_unpack() {
	if use autoconfig; then
		git-r3_fetch https://github.com/libretro/retroarch-joypad-autoconfig.git HEAD
		git-r3_checkout https://github.com/libretro/retroarch-joypad-autoconfig.git \
			"${WORKDIR}"/autoconfig
	fi
	git-r3_fetch
	git-r3_checkout
}

src_prepare() {
	epatch "${FILESDIR}/${P}-build.patch" \
		"${FILESDIR}/${PN}-python.patch"

	if use python; then
		sed -i qb/config.libs.sh \
			-e "s:%PYTHON_VER%:${EPYTHON/python/}:" \
			|| die
	fi
	if use autoconfig; then
		sed -i retroarch.cfg \
			-e 's:# joypad_autoconfig_dir =:joypad_autoconfig_dir = "/usr/share/retroarch/retroarch-joypad-autoconfig":' \
			|| die
	fi
	if use cores; then
		sed -i retroarch.cfg \
			-e 's:# libretro_directory =:libretro_directory = "/usr/lib/libretro":' \
			|| die
		sed -i retroarch.cfg \
			-e 's:# libretro_info_path =:libretro_info_path = "/usr/lib/libretro":' \
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
		$(use_enable cg) \
		$(use_enable egl) \
		$(use_enable fbo) \
		$(use_enable ffmpeg) \
		$(use_enable gles) \
		$(use_enable gles3) \
		$(use_enable glui) \
		$(use_enable jack) \
		$(use_enable kms) \
		$(use_enable lakka) \
		$(use_enable netplay) \
		$(use_enable openal al) \
		$(use_enable opengl) \
		$(use_enable openvg vg) \
		$(use_enable oss) \
		$(use_enable pulseaudio pulse) \
		$(use_enable python) \
		$(use_enable sdl) \
		$(use_enable sdl2) \
		$(use_enable threads) \
		$(use_enable truetype freetype) \
		$(use_enable udev) \
		$(use_enable v4l2) \
		$(use_enable x11) \
		$(use_enable xinerama) \
		$(use_enable xmb) \
		$(use_enable xml libxml2) \
		$(use_enable xv xvideo) \
		$(use_enable zlib) \
		--enable-dynamic \
		--with-man_dir="/usr/share/man/man1" \
		|| die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README.md AUTHORS
	prepgamesdirs
	if use autoconfig; then
		insinto /usr/share/retroarch/retroarch-joypad-autoconfig
		doins "${WORKDIR}"/autoconfig/udev/*.cfg
	fi
}

pkg_postinst() {
	if use cores; then
		elog "Changed libretro_directory and libretro_info_path of \"/etc/retroarch.cfg\" to"
		elog "\"/usr/lib/libretro\""
		elog ""
	fi
	if ! use cores ; then
		elog "Don't forget to set your libretro_directory and libretro_info_path"
		elog "to the location of your libretro cores, like \"/usr/lib/libretro/\""
		elog ""
	fi
	if use autoconfig; then
		elog "Changed joypad_autoconfig_dir of \"/etc/retroarch.cfg\" to"
		elog "\"/usr/share/retroarch/retroarch-joypad-autoconfig\""
		elog ""
	fi
}
