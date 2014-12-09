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
IUSE="alsa +assets +cg +cores egl +fbo ffmpeg gles gles3 glui jack +joypad_autoconfig kms +lakka +netplay openal +opengl oss pulseaudio python sdl sdl2 +shaders +truetype +threads +udev v4l2 openvg +overlays +xml +xmb xv xinerama +x11 zlib"

RDEPEND="alsa? ( media-libs/alsa-lib )
	assets? ( games-emulation/retroarch-assets )
	cg? ( media-gfx/nvidia-cg-toolkit )
	cores? ( games-emulation/libretro-meta )
	egl? ( media-libs/mesa[egl] )
	ffmpeg? ( >=media-video/ffmpeg-2.1.3 )
	gles? ( media-libs/mesa[gles2] )
	jack? ( >=media-sound/jack-audio-connection-kit-0.120.1 )
	joypad_autoconfig? ( games-emulation/retroarch-joypad-autoconfig )
	openal? ( media-libs/openal )
	opengl? ( media-libs/mesa )
	openvg? ( media-libs/mesa[openvg] )
	pulseaudio? ( media-sound/pulseaudio )
	python? ( ${PYTHON_DEPS} )
	sdl2? ( media-libs/libsdl2[joystick] )
	sdl? ( >=media-libs/libsdl-1.2.10[joystick] )
	shaders? ( games-emulation/common-shaders )
	truetype? ( media-libs/freetype:2 )
	udev? ( >=x11-libs/libxkbcommon-0.4.0
	v4l2? ( media-libs/libv4l )
	virtual/udev
	overlays? ( games-emulation/common-overlays )
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
	      cg? ( opengl )
	      egl? ( x11 )
	      opengl? ( !gles )
	      sdl2? ( !sdl )
	      lakka? ( assets )
	      xmb? ( assets )
	      shaders? ( cg )
	      xinerama? ( x11 )
	      xv? ( x11 )"

pkg_setup() {
	use python && python-single-r1_pkg_setup
	games_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}/${P}-build.patch" \
		"${FILESDIR}/${PN}-python.patch"

	if use python; then
		sed -i qb/config.libs.sh \
			-e "s:%PYTHON_VER%:${EPYTHON/python/}:" \
			|| die
	fi
	#fixing a little QA error on desktop file
	sed -i debian/retroarch.desktop \
		-e 's:Categories=Game.*:Categories=Game;:' \
		|| die

	#changing default options to a more sensible default
	sed -i retroarch.cfg \
		-e 's:# libretro_directory =:libretro_directory = "/usr/lib/libretro/":' \
		|| die
	sed -i retroarch.cfg \
		-e 's:# libretro_info_path =:libretro_info_path = "/usr/share/libretro/info/":' \
		|| die
	sed -i retroarch.cfg \
		-e 's:# joypad_autoconfig_dir =:joypad_autoconfig_dir = "/usr/share/retroarch/autoconfig/":' \
		|| die
	sed -i retroarch.cfg \
		-e 's:# rgui_browser_directory =:rgui_browser_directory = "~/":' \
		|| die
	sed -i retroarch.cfg \
		-e 's:# assets_directory =:assets_directory = "/usr/share/retroarch/assets/":' \
		|| die
	sed -i retroarch.cfg \
		-e 's:# rgui_config_directory =:rgui_config_directory = "~/.config/retroarch/":' \
		|| die
	sed -i retroarch.cfg \
		-e 's:# video_shader_dir =:video_shader_dir = "/usr/share/libretro/shaders/":' \
		|| die
	sed -i retroarch.cfg \
		-e 's:# video_filter_dir =:video_filter_dir = "/usr/lib/retroarch/filters/video/":' \
		|| die
	sed -i retroarch.cfg \
		-e 's:# audio_filter_dir =:audio_filter_dir = "/usr/lib/retroarch/filters/audio/":' \
		|| die
	sed -i retroarch.cfg \
		-e 's:# overlay_directory =:overlay_directory = "/usr/share/libretro/overlays/":' \
		|| die
	sed -i retroarch.cfg \
		-e 's:# system_directory =:system_directory = "~/.local/share/retroarch/system/":' \
		|| die
	sed -i retroarch.cfg \
		-e 's:# savestate_directory =:savestate_directory = "~/.local/share/retroarch/savestates/":' \
		|| die
	sed -i retroarch.cfg \
		-e 's:# savefile_directory =:savefile_directory = "~/.local/share/retroarch/savefiles/":' \
		|| die
	sed -i retroarch.cfg \
		-e 's:# content_directory =:content_directory = "~/.local/share/retroarch/content/":' \
		|| die
	sed -i retroarch.cfg \
		-e 's:# screenshot_directory =:screenshot_directory = "~/.local/share/retroarch/screenshots/":' \
		|| die
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

src_compile() {
	emake
	emake -C gfx/video_filters/
	emake -C audio/audio_filters/
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README.md AUTHORS
	insinto /usr/share/applications/
	doins "${S}"/debian/retroarch.desktop
	insinto /usr/lib/retroarch/filters/video/
	doins "${S}"/gfx/video_filters/*.so
	doins "${S}"/gfx/video_filters/*.filt
	insinto /usr/lib/retroarch/filters/audio/
	doins "${S}"/audio/audio_filters/*.so
	doins "${S}"/audio/audio_filters/*.dsp
	keepdir /usr/lib/libretro/
	keepdir /usr/share/libretro/info/
	keepdir /usr/share/libretro/shaders/
	keepdir /usr/share/libretro/overlays/
	keepdir /usr/share/retroarch/assets/
	keepdir /usr/share/retroarch/autoconfig/
	prepgamesdirs
}

pkg_postinst() {
	elog ""
	elog "Please note that this ebuild modifies the standard configuration file /etc/retroarch.cfg"
	elog "to make it work with almost everything out of the box."
	ewarn ""
	ewarn "You need to make sure that all directories exist or you must modify your retroarch.cfg accordingly."
	ewarn "To create the needed directories for your user run as \$USER (not as root!):"
	ewarn ""
	ewarn "\$ mkdir -p ~/.local/share/retroarch/{savestates,savefiles,screenshots,content,system}"
	ewarn ""
	elog "After that you can find your savefiles, screenshots etc in ~/.local/share/retroarch."
	elog ""
	elog "* This only works if you remove your own retroarch.cfg from ~/.config/retroarch before the first start *"
	elog ""
}
