# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{3_2,3_3,3_4} )

inherit flag-o-matic games python-single-r1

DESCRIPTION="Universal frontend for libretro-based emulators"
HOMEPAGE="http://www.libretro.com/"

LICENSE="GPL-3"
SLOT="0"

# To avoid fatal dependency failures for users enabling the "python" USE flag, a
# default "python_single_target_python*" USE flag *MUST* be set below to the
# default version of Python 3 for default Portage profiles.
IUSE="alsa +armvfp +assets +cg +cores +database egl +fbo ffmpeg gles2 gles3 jack +joypad_autoconfig kms libusb +netplay +neon openal +opengl oss pulseaudio sdl sdl2 +shaders +truetype +threads +udev v4l2 +overlays +xml +xmb xv xinerama +x11 zlib python python_single_target_python3_3 +python_single_target_python3_4"
REQUIRED_USE="
	|| ( alsa jack openal oss pulseaudio )
	|| ( opengl sdl sdl2 )
	alsa? ( threads )
	arm? ( gles2? ( egl ) )
	cg? ( opengl )
	egl? ( opengl )
	gles2? ( !cg opengl )
	gles3? ( gles2 )
	kms? ( egl )
	python? ( ${PYTHON_REQUIRED_USE} )
	sdl2? ( !sdl )
	xinerama? ( x11 )
	xmb? ( assets )
	xmb? ( opengl )
	xv? ( x11 )
"

# This ebuild no longer accepts an "openvg" USE flag, as the underlying "mesa"
# 11.0.x ebuilds no longer accept that flag either. Whether this a bug or
# intentional is unclear. In either case, attempting to pass that flag to "mesa"
# will result in Portage downgrading "mesa" with the following unreadable block:
# 
#     [blocks B      ] =media-libs/mesa-10.3.7-r1 ("=media-libs/mesa-10.3.7-r1" is blocking app-eselect/eselect-opengl-1.3.1-r4)
RDEPEND="
	alsa? ( media-libs/alsa-lib:0= )
	assets? ( games-emulation/retroarch-assets:0= )
	cg? ( media-gfx/nvidia-cg-toolkit:0= )
	cores? ( games-emulation/libretro-meta:0= )
	database? ( games-emulation/libretro-database:0= )
	ffmpeg? ( >=media-video/ffmpeg-2.1.3:0= )
	jack? ( >=media-sound/jack-audio-connection-kit-0.120.1:0= )
	joypad_autoconfig? ( games-emulation/retroarch-joypad-autoconfig:0= )
	libusb? ( virtual/libusb:1= )
	openal? ( media-libs/openal:0= )
	opengl? ( media-libs/mesa:0=[egl?,gles2?] )
	pulseaudio? ( media-sound/pulseaudio:0= )
	python? ( ${PYTHON_DEPS} )
	sdl? ( >=media-libs/libsdl-1.2.10:0=[joystick] )
	sdl2? ( media-libs/libsdl2:0=[joystick] )
	shaders? ( games-emulation/common-shaders:0= )
	truetype? ( media-libs/freetype:2= )
	udev? (
		virtual/udev:0=
		x11-drivers/xf86-input-evdev:0=
		>=x11-libs/libxkbcommon-0.4.0:0=
		overlays? ( games-emulation/common-overlays:0= )
		v4l2? ( media-libs/libv4l:0= )
	)
	x11? ( x11-base/xorg-server:0= )
	xinerama? ( x11-libs/libXinerama:0= )
	xml? ( dev-libs/libxml2:2= )
	xv? ( x11-libs/libXv:0= )
	zlib? ( sys-libs/zlib:0= )
"
DEPEND="virtual/pkgconfig
	${RDEPEND}"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3

	EGIT_REPO_URI="git://github.com/libretro/RetroArch.git"
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="https://github.com/libretro/RetroArch/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/RetroArch-${PV}"
fi

pkg_setup() {
	use python && python-single-r1_pkg_setup
	games_pkg_setup
}

src_prepare() {
	epatch \
		"${FILESDIR}/${P}-build.patch" \
		"${FILESDIR}/${P}-python.patch"

	if use python; then
		sed -i qb/config.libs.sh \
			-e "s:%PYTHON_VER%:${EPYTHON/python/}:" \
			|| die
	fi

	#changing default options to a more sensible default
	sed -i retroarch.cfg \
		-e 's:# libretro_directory =:libretro_directory = "'${EROOT}'usr/'$(get_libdir)'/libretro/":' \
		-e 's:# libretro_info_path =:libretro_info_path = "'${EROOT}'usr/share/libretro/info/":' \
		-e 's:# joypad_autoconfig_dir =:joypad_autoconfig_dir = "'${EROOT}'usr/share/retroarch/autoconfig/":' \
		-e 's:# rgui_browser_directory =:rgui_browser_directory = "~/":' \
		-e 's:# assets_directory =:assets_directory = "'${EROOT}'usr/share/retroarch/assets/":' \
		-e 's:# rgui_config_directory =:rgui_config_directory = "~/.config/retroarch/":' \
		-e 's:# video_shader_dir =:video_shader_dir = "'${EROOT}'usr/share/libretro/shaders/":' \
		-e 's:# video_filter_dir =:video_filter_dir = "'${EROOT}'usr/'$(get_libdir)'/retroarch/filters/video/":' \
		-e 's:# audio_filter_dir =:audio_filter_dir = "'${EROOT}'usr/'$(get_libdir)'/retroarch/filters/audio/":' \
		-e 's:# overlay_directory =:overlay_directory = "'${EROOT}'usr/share/libretro/overlays/":' \
		-e 's:# content_database_path =:content_database_path = "'${EROOT}'usr/share/libretro/data/":' \
		-e 's:# cheat_database_path =:cheat_database_path = "'${EROOT}'usr/share/libretro/cheats/":' \
		-e 's:# system_directory =:system_directory = "~/.local/share/retroarch/system/":' \
		-e 's:# savestate_directory =:savestate_directory = "~/.local/share/retroarch/savestates/":' \
		-e 's:# savefile_directory =:savefile_directory = "~/.local/share/retroarch/savefiles/":' \
		-e 's:# content_directory =:content_directory = "~/":' \
		-e 's:# screenshot_directory =:screenshot_directory = "~/.local/share/retroarch/screenshots/":' \
		-e 's:# extraction_directory =:extraction_directory = "'${EROOT}'tmp/":' \
		|| die
}

src_configure() {
	if use cg; then
		append-ldflags -L"${EROOT}"opt/nvidia-cg-toolkit/$(get_libdir)
		append-cflags -I"${EROOT}"opt/nvidia-cg-toolkit/include
	fi

	# Disable OpenVG support. See above.
	egamesconf \
		$(use_enable alsa) \
		$(use_enable armvfp floathard) \
		$(use_enable cg) \
		$(use_enable egl) \
		$(use_enable fbo) \
		$(use_enable ffmpeg) \
		$(use_enable gles2) \
		$(use_enable gles3) \
		$(use_enable jack) \
		$(use_enable kms) \
		$(use_enable libusb) \
		$(use_enable netplay) \
		$(use_enable neon) \
		$(use_enable openal al) \
		$(use_enable opengl) \
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
		--enable-glui \
		--disable-vg \
		--with-man_dir=${EROOT}"usr/share/man/man1" \
		|| die
}

src_compile() {
	emake
	emake -C gfx/video_filters/
	emake -C audio/audio_filters/
}

src_install() {
	emake DESTDIR="${ED}" install || die
	dodoc README.md
	insinto /usr/$(get_libdir)/retroarch/filters/video/
	doins "${S}"/gfx/video_filters/*.so
	doins "${S}"/gfx/video_filters/*.filt
	insinto /usr/$(get_libdir)/retroarch/filters/audio/
	doins "${S}"/audio/audio_filters/*.so
	doins "${S}"/audio/audio_filters/*.dsp
	keepdir /usr/$(get_libdir)/libretro/
	keepdir /usr/share/libretro/info/
	keepdir /usr/share/libretro/shaders/
	keepdir /usr/share/libretro/overlays/
	keepdir /usr/share/libretro/cheats/
	keepdir /usr/share/libretro/data/
	keepdir /usr/share/retroarch/assets/
	keepdir /usr/share/retroarch/autoconfig/
	prepgamesdirs
}

pkg_preinst() {
	if ! has_version "=${CATEGORY}/${P}"; then
		first_install="1"
	fi
}

pkg_postinst() {
	if [[ "${first_install}" == "1" ]]; then
		ewarn ""
		ewarn "You need to make sure that all directories exist or you must modify your retroarch.cfg accordingly."
		ewarn "To create the needed directories for your user run as \$USER (not as root!):"
		ewarn ""
		ewarn "\$ mkdir -p ~/.local/share/retroarch/{savestates,savefiles,screenshots,system}"
		ewarn ""
		ewarn "This message will only be displayed once!"
		ewarn ""
	fi
}
