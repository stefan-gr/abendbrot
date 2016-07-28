# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python{3_2,3_3,3_4,3_5} )

inherit flag-o-matic libretro python-single-r1

DESCRIPTION="Universal frontend for libretro-based emulators"
HOMEPAGE="http://www.libretro.com/"

LICENSE="GPL-3"
SLOT="0"

#FIXME: Revaluate the "wayland? ( egl )" entry below. Due to unresolved upstream
#issues, Wayland support erroneously requires EGL support. Ideally, it
#shouldn't. When upstream resolves this, remove this entry. See also:
#    https://github.com/stefan-gr/abendbrot/issues/7#issuecomment-204541979

# To avoid fatal dependency failures for users enabling the "python" USE flag, a
# default "python_single_target_python*" USE flag *MUST* be set below to the
# default version of Python 3 for default Portage profiles.
IUSE="+7zip alsa +armvfp +assets +cg cheevos +cores +database egl +fbo ffmpeg gles2 gles3 jack +joypad_autoconfig kms libass libusb +materialui +netplay +neon +network openal +opengl oss +overlays pulseaudio sdl sdl2 +shaders +truetype +threads +udev v4l2 vulkan wayland X xinerama +xmb +xml xv zlib cpu_flags_x86_sse2 python python_single_target_python3_3 +python_single_target_python3_4 python_single_target_python3_5"

REQUIRED_USE="
	|| ( alsa jack openal oss pulseaudio )
	|| ( opengl sdl sdl2 vulkan )
	|| ( kms X wayland )
	alsa? ( threads )
	arm? ( gles2? ( egl ) )
	cg? ( opengl )
	egl? ( opengl )
	gles2? ( !cg opengl )
	gles3? ( gles2 )
	kms? ( egl )
	libass? ( ffmpeg )
	netplay? ( network )
	python? ( ${PYTHON_REQUIRED_USE} )
	sdl2? ( !sdl )
	wayland? ( egl )
	xinerama? ( X )
	xmb? ( assets opengl )
	xv? ( X )
"

#FIXME: Correct the "vulkan" USE flag dependency below. Since the official Mesa
#ebuild does *NOT* officially support Vulkan yet, a fake "mesa[vulkan?]"
#dependency has been added as a placeholder below.

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
	libass? ( media-libs/libass:0= )
	libusb? ( virtual/libusb:1= )
	openal? ( media-libs/openal:0= )
	opengl? ( media-libs/mesa:0=[egl?,gles2?] )
	overlays? ( games-emulation/common-overlays:0= )
	pulseaudio? ( media-sound/pulseaudio:0= )
	python? ( ${PYTHON_DEPS} )
	sdl? ( >=media-libs/libsdl-1.2.10:0=[joystick] )
	sdl2? ( media-libs/libsdl2:0=[joystick] )
	truetype? ( media-libs/freetype:2= )
	udev? ( virtual/udev:0=
		X? ( x11-drivers/xf86-input-evdev:0= )
	)
	vulkan? ( media-libs/mesa:0=[vulkan?] )
	v4l2? ( media-libs/libv4l:0= )
	wayland? ( media-libs/mesa:0=[wayland?] )
	X? (
		x11-base/xorg-server:0=
		>=x11-libs/libxkbcommon-0.4.0:0=
	)
	xinerama? ( x11-libs/libXinerama:0= )
	xml? ( dev-libs/libxml2:2= )
	xv? ( x11-libs/libXv:0= )
	zlib? ( sys-libs/zlib:0= )
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"

PDEPEND="shaders? ( !cg? ( games-emulation/common-shaders:0=[-cg] )
		cg? ( games-emulation/common-shaders:0=[cg] ) )
"
if [[ ${PV} == 9999 ]]; then
	inherit git-r3

	EGIT_REPO_URI="git://github.com/libretro/RetroArch.git"
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="https://github.com/libretro/RetroArch/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 x86"
	S="${WORKDIR}/RetroArch-${PV}"
fi

pkg_setup() {
	use python && python-single-r1_pkg_setup
}

src_prepare() {
	epatch \
		"${FILESDIR}/${P}-build.patch" \
		"${FILESDIR}/${P}-python.patch"

	# If Python support is enabled, use the currently enabled "python" binary.
	if use python; then
		sed -i qb/config.libs.sh \
			-e "s:%PYTHON_VER%:${EPYTHON/python/}:" \
			|| die '"sed" failed.'
	fi

	# Install application data and pixmaps to standard directories.
	sed -i Makefile \
		-e 's:$(DESTDIR)$(PREFIX)/share/\(applications\|pixmaps\):$(DESTDIR)usr/share/\1:' \
		|| die '"sed" failed.'

	# Absolute path of the directory containing Retroarch shared libraries.
	export RETROARCH_LIB_DIR="${EROOT}usr/$(get_libdir)/retroarch"

	# Absolute path of the directory containing Libretro shared libraries.
	export LIBRETRO_LIB_DIR="${EROOT}usr/$(get_libdir)/libretro"

	# Replace stock defaults with Gentoo-specific defaults.
	sed -i retroarch.cfg \
		-e 's:# \(libretro_directory =\):\1 "'${LIBRETRO_LIB_DIR}'/":' \
		-e 's:# \(libretro_info_path =\):\1 "'${LIBRETRO_DATA_DIR}'/info/":' \
		-e 's:# \(joypad_autoconfig_dir =\):\1 "'${RETROARCH_DATA_DIR}'/autoconfig/":' \
		-e 's:# \(assets_directory =\):\1 "'${RETROARCH_DATA_DIR}'/assets/":' \
		-e 's:# \(rgui_config_directory =\):\1 "~/.config/retroarch/":' \
		-e 's:# \(video_shader_dir =\):\1 "'${LIBRETRO_DATA_DIR}'/shaders/":' \
		-e 's:# \(video_filter_dir =\):\1 "'${RETROARCH_LIB_DIR}'/filters/video/":' \
		-e 's:# \(audio_filter_dir =\):\1 "'${RETROARCH_LIB_DIR}'/filters/audio/":' \
		-e 's:# \(overlay_directory =\):\1 "'${LIBRETRO_DATA_DIR}'/overlays/":' \
		-e 's:# \(content_database_path =\):\1 "'${LIBRETRO_DATA_DIR}'/data/":' \
		-e 's:# \(cheat_database_path =\):\1 "'${LIBRETRO_DATA_DIR}'/cheats/":' \
		-e 's:# \(system_directory =\):\1 "~/.local/share/retroarch/system/":' \
		-e 's:# \(savestate_directory =\):\1 "~/.local/share/retroarch/savestates/":' \
		-e 's:# \(savefile_directory =\):\1 "~/.local/share/retroarch/savefiles/":' \
		-e 's:# \(screenshot_directory =\):\1 "~/.local/share/retroarch/screenshots/":' \
		-e 's:# \(extraction_directory =\):\1 "'${EROOT}'tmp/":' \
		-e 's:# \(content_directory =\):\1 "~/":' \
		-e 's:# \(rgui_browser_directory =\):\1 "~/":' \
		|| die '"sed" failed.'
	default_src_prepare
}

src_configure() {
	if use cg; then
		append-ldflags -L"${EROOT}"opt/nvidia-cg-toolkit/$(get_libdir)
		append-cflags  -I"${EROOT}"opt/nvidia-cg-toolkit/include
	fi

	#FIXME: Netplay is currently required, due to the following outstanding bug:
	#    https://github.com/libretro/RetroArch/issues/2663
	#When fixed, replace the "--enable-netplay" below with:
	#    $(use_enable netplay) \

	# Note that OpenVG support is hard-disabled. (See ${RDEPEND} above.)
	econf \
		$(use_enable 7zip) \
		$(use_enable alsa) \
		$(use_enable armvfp floathard) \
		$(use_enable cheevos) \
		$(use_enable cg) \
		$(use_enable cpu_flags_x86_sse2 sse) \
		$(use_enable egl) \
		$(use_enable fbo) \
		$(use_enable ffmpeg) \
		$(use_enable gles2 gles) \
		$(use_enable gles3) \
		$(use_enable jack) \
		$(use_enable kms) \
		$(use_enable libass ssa) \
		$(use_enable libusb) \
		$(use_enable materialui) \
		$(use_enable network networking) \
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
		$(use_enable vulkan) \
		$(use_enable wayland) \
		$(use_enable X x11) \
		$(use_enable xinerama) \
		$(use_enable xmb) \
		$(use_enable xml libxml2) \
		$(use_enable xv xvideo) \
		$(use_enable zlib) \
		--enable-dynamic \
		--enable-netplay \
		--disable-vg \
		--with-man_dir="${EROOT}"usr/share/man/man1
}

src_compile() {
	emake
	emake -C gfx/video_filters/
	emake -C audio/audio_filters/
}

src_install() {
	# Install core files and directories.
	emake DESTDIR="${ED}" install

	# Install documentation.
	dodoc README.md

	# Install video filters.
	insinto ${RETROARCH_LIB_DIR}/filters/video/
	doins "${S}"/gfx/video_filters/*.so
	doins "${S}"/gfx/video_filters/*.filt

	# Install audio filters.
	insinto ${RETROARCH_LIB_DIR}/filters/audio/
	doins "${S}"/audio/audio_filters/*.so
	doins "${S}"/audio/audio_filters/*.dsp

	# Preserve empty directories.
	keepdir ${LIBRETRO_LIB_DIR}
	keepdir ${LIBRETRO_DATA_DIR}/info/
	keepdir ${LIBRETRO_DATA_DIR}/shaders/
	keepdir ${LIBRETRO_DATA_DIR}/overlays/
	keepdir ${LIBRETRO_DATA_DIR}/cheats/
	keepdir ${LIBRETRO_DATA_DIR}/data/
	keepdir ${RETROARCH_DATA_DIR}/assets/
	keepdir ${RETROARCH_DATA_DIR}/autoconfig/
}

pkg_preinst() {
	if ! has_version "<=${CATEGORY}/${PN}-${PVR}" ; then
		first_install="1"
	else
		if [[ "${PV}" < "9999" ]]; then
			if has_version "<${CATEGORY}/${PN}-1.3.6-r2"; then
				upgrade_info="1"
			fi
		else
			if has_version "<${CATEGORY}/${PN}-9999-r2" ; then
				upgrade_info="1"
			fi
		fi
	fi
}

pkg_postinst() {
	if [[ "${upgrade_info}" == "1" ]]; then
		ewarn ""
		ewarn "You need to make sure that all directories exist or you must modify your retroarch.cfg accordingly."
		ewarn "To create the needed directories for your user run as \$USER (not as root!):"
		ewarn ""
		ewarn "\$ mkdir -p ~/.local/share/retroarch/{savestates,savefiles,screenshots,system}"
		ewarn ""
	fi
	if [[ "${upgrade_info}" == "1" ]]; then
		ewarn ""
		ewarn "The path to cores and datafiles changed to [/usr/lib64/libretro, /usr/share/libretro] due to EAPI 6 update."
		ewarn "This can be changed via gui or cfg file found in \"\${HOME}/.config/retroarch/retroarch.cfg\""
		ewarn ""
	fi
}
