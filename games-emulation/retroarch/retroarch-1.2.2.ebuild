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
IUSE="alsa +armvfp +assets +cg +cores +database egl +fbo ffmpeg gles2 gles3 jack +joypad_autoconfig kms libusb +netplay +neon +network openal +opengl oss pulseaudio sdl sdl2 +shaders +truetype +threads +udev v4l2 +overlays +xml +xmb xv xinerama +x11 zlib python python_single_target_python3_3 +python_single_target_python3_4"
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
	netplay? ( network )
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
	overlays? ( games-emulation/common-overlays:0= )
	pulseaudio? ( media-sound/pulseaudio:0= )
	python? ( ${PYTHON_DEPS} )
	sdl? ( >=media-libs/libsdl-1.2.10:0=[joystick] )
	sdl2? ( media-libs/libsdl2:0=[joystick] )
	shaders? ( games-emulation/common-shaders:0= )
	truetype? ( media-libs/freetype:2= )
	udev? ( virtual/udev:0= )
	v4l2? ( media-libs/libv4l:0= )
	x11? (
		x11-base/xorg-server:0=
		x11-drivers/xf86-input-evdev:0=
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

if [[ ${PV} == 9999 ]]; then
	inherit games git-r3

	EGIT_REPO_URI="git://github.com/libretro/RetroArch.git"
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="https://github.com/libretro/RetroArch/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 x86"
	S="${WORKDIR}/RetroArch-${PV}"
fi

# Absolute path of the directory containing libretro shared libraries.
LIBRETRO_LIB_DIR=${GAMES_PREFIX}/$(get_libdir)/libretro

# Absolute path of the directory containing retroarch shared libraries.
RETROARCH_LIB_DIR=${GAMES_PREFIX}/"$(get_libdir)"/retroarch

# Absolute path of the directory containing libretro data files.
LIBRETRO_DATA_DIR=${GAMES_DATADIR}/libretro

# Absolute path of the directory containing retroarch data files.
RETROARCH_DATA_DIR=${GAMES_DATADIR}/retroarch

pkg_setup() {
	use python && python-single-r1_pkg_setup
	games_pkg_setup
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

	# Install application data and pixmaps to standard directories rather than
	# under ${GAMES_PREFIX} (e.g., "/usr/games").
	sed -i Makefile \
		-e 's:$(DESTDIR)$(PREFIX)/share/\(applications\|pixmaps\):$(DESTDIR)/usr/share/\1:' \
		|| die '"sed" failed.'

	# Replace stock defaults with Gentoo-specific defaults.
	sed -i retroarch.cfg \
		-e 's:# \(libretro_directory =\):\1 "'${EROOT}${LIBRETRO_LIB_DIR}'/":' \
		-e 's:# \(libretro_info_path =\):\1 "'${EROOT}${LIBRETRO_DATA_DIR}'/info/":' \
		-e 's:# \(joypad_autoconfig_dir =\):\1 "'${EROOT}${RETROARCH_DATA_DIR}'/autoconfig/":' \
		-e 's:# \(assets_directory =\):\1 "'${EROOT}${RETROARCH_DATA_DIR}'/assets/":' \
		-e 's:# \(rgui_config_directory =\):\1 "~/.config/retroarch/":' \
		-e 's:# \(video_shader_dir =\):\1 "'${EROOT}${LIBRETRO_DATA_DIR}'/shaders/":' \
		-e 's:# \(video_filter_dir =\):\1 "'${EROOT}${RETROARCH_LIB_DIR}'/filters/video/":' \
		-e 's:# \(audio_filter_dir =\):\1 "'${EROOT}${RETROARCH_LIB_DIR}'/filters/audio/":' \
		-e 's:# \(overlay_directory =\):\1 "'${EROOT}${LIBRETRO_DATA_DIR}'/overlays/":' \
		-e 's:# \(content_database_path =\):\1 "'${EROOT}${LIBRETRO_DATA_DIR}'/data/":' \
		-e 's:# \(cheat_database_path =\):\1 "'${EROOT}${LIBRETRO_DATA_DIR}'/cheats/":' \
		-e 's:# \(system_directory =\):\1 "~/.local/share/retroarch/system/":' \
		-e 's:# \(savestate_directory =\):\1 "~/.local/share/retroarch/savestates/":' \
		-e 's:# \(savefile_directory =\):\1 "~/.local/share/retroarch/savefiles/":' \
		-e 's:# \(screenshot_directory =\):\1 "~/.local/share/retroarch/screenshots/":' \
		-e 's:# \(extraction_directory =\):\1 "'${EROOT}'tmp/":' \
		-e 's:# \(content_directory =\):\1 "~/":' \
		-e 's:# \(rgui_browser_directory =\):\1 "~/":' \
		|| die '"sed" failed.'
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

	# Note that egamesconf() passes the following default parameters:
	#
	#    --prefix="${GAMES_PREFIX}" \
	#    --libdir="$(games_get_libdir)" \
	#    --datadir="${GAMES_DATADIR}" \
	#    --sysconfdir="${GAMES_SYSCONFDIR}" \
	#    --localstatedir="${GAMES_STATEDIR}" \
	#
	# Note that OpenVG support is hard-disabled. (See ${RDEPEND} above.)
	egamesconf \
		$(use_enable alsa) \
		$(use_enable armvfp floathard) \
		$(use_enable cg) \
		$(use_enable egl) \
		$(use_enable fbo) \
		$(use_enable ffmpeg) \
		$(use_enable gles2 gles) \
		$(use_enable gles3) \
		$(use_enable jack) \
		$(use_enable kms) \
		$(use_enable libusb) \
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
		$(use_enable x11) \
		$(use_enable xinerama) \
		$(use_enable xmb) \
		$(use_enable xml libxml2) \
		$(use_enable xv xvideo) \
		$(use_enable zlib) \
		--enable-dynamic \
		--enable-netplay \
		--disable-vg \
		--with-man_dir=${EROOT}"usr/share/man/man1"
}

src_compile() {
	emake GLOBAL_CONFIG_DIR="${GAMES_SYSCONFDIR}"
	emake GLOBAL_CONFIG_DIR="${GAMES_SYSCONFDIR}" -C gfx/video_filters/
	emake GLOBAL_CONFIG_DIR="${GAMES_SYSCONFDIR}" -C audio/audio_filters/
}

src_install() {
	# Install core files and directories.
	emake DESTDIR="${ED}" GLOBAL_CONFIG_DIR="${GAMES_SYSCONFDIR}" install

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

	# Correct permissions and ownership.
	prepgamesdirs
}

pkg_preinst() {
	if ! has_version "=${CATEGORY}/${PN}-${PVR}"; then
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
