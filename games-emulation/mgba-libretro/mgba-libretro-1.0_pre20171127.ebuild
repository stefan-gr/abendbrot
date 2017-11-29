# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# Minimum "cmake" version required by mGBA, defined *BEFORE* inheriting the
# "cmake-utils" eclass.
CMAKE_MIN_VERSION=2.8.11

# Instruct "cmake" to *NOT* ignore unrecognized CLI options. (Why on Satan's
# red earth is ignoring such options the eclass default?)
CMAKE_WARN_UNUSED_CLI=1

# Here's where things get confusing. Strap in, because you're in for a ride!
# There exist two mGBA repositories:
#
# * "https://github.com/mgba-emu/mgba.git", the official mGBA repository.
# * "https://github.com/libretro/mgba.git", the Libretro mGBA repository
#
# Since the latter tracks the former, the two superficially resemble one other.
# All similarities end at their build systems, however. The former ships with:
# 
# * A dynamic "cmake"-based build system reading "CMakeLists.txt" as input and
#   writing a "Makefile" as output. This system provides out-of-the-box support 
#   for compiling the mGBA Libretro core via the "-DBUILD_LIBRETRO=1"
#   configuration-time option.
#
# The latter ships with two (!) parallel build systems, only one of which is
# documented and only one of which works (...and the documented system is not
# the system that works):
#
# * A dynamic "cmake"-based build system reading "CMakeLists.txt" as input and
#   overwriting the existing "Makefile" as output. Despite explicitly including
#   a configuration-time option to enable Libretro support (e.g.,
#   "-DBUILD_LIBRETRO=1"), this system fails to compile on enabling this option.
# * An undocumented static "make"-based build system reading "Makefile" which
#   reads "Makefile.libretro" as input. Unlike the prior system, this system
#   actually succeeds in compiling the mGBA Libretro core. Unsurprisingly, this 
#   is the system used by the official "libretro-super" project to build this
#   core. Unfortunately, this system provides substantially fewer
#   configuration-time options than the prior system.
#
# There exist two options, therefore: "cmake" in the official mGBA repository
# and "make" in the Libretro mGBA repository. Since the former successfully
# compiles the mGBA Libretro core *AND* provides substantially more 
# configuration-time options, we prefer the former. Interestingly, this
# archlinux PKGBUILD for the mGBA Libretro core has made a similar choice:
#
#     https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=libretro-mgba-git

LIBRETRO_REPO_NAME="mgba-emu/mgba"

LIBRETRO_COMMIT_SHA="721224306c0fe2f7d9494387376bf5394966dadb"
inherit libretro-core cmake-utils

DESCRIPTION="libretro implementation of mGBA. (Game Boy Advance)"
HOMEPAGE="https://github.com/mgba-emu/mgba"
KEYWORDS="~amd64 ~x86"

LICENSE="MPL-2.0"
SLOT="0"
IUSE="epoxy ffmpeg gles2 imagemagick lto lzma +opengl pgo pgopost png +zip zlib"
REQUIRED_USE="
	epoxy? ( gles2 )
	gles2? ( opengl )
	pgopost? ( pgo )
	png? ( zlib )
"

DEPEND="
	epoxy? ( media-libs/libepoxy:0= )
	ffmpeg? ( virtual/ffmpeg:0= )
	imagemagick? ( media-gfx/imagemagick:0= )
	lzma? ( app-arch/xz-utils:0= )
	png? ( media-libs/libpng:0= )
	opengl? ( media-libs/mesa:0=[gles2?] )
	png? ( media-libs/libpng:0= )
	zip? ( dev-libs/libzip:0= )
	zlib? ( sys-libs/zlib:0= )
"
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

src_unpack() {
	libretro-core_src_unpack

	# For safety, unbundle most bundled third-party libraries.
	mkdir "${S}"/src/third-party-unused
	mv \
		"${S}"/src/third-party/{libpng,lzma,zlib} \
		"${S}"/src/third-party-unused/
}

src_configure() {
	local mycmakeargs=(
		# For security, install into the standard games directories.
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}"/usr
		-DCMAKE_INSTALL_DOCDIR="${EPREFIX}"/usr/share/doc
		-DCMAKE_INSTALL_MANDIR="${EPREFIX}"/usr/share/man/man1
		-DCMAKE_INSTALL_LIBDIR="${EPREFIX}"/usr/"$(get_libdir)"/libretro
		-DPGO_DIR="${T}"/pgo

		# Enable only mGBA's Libretro core as a statically linked library.
		-DBUILD_LIBRETRO=ON
		-DSKIP_LIBRARY=ON

		# Disable all mGBA-specific frontends. RetroArch is our frontend!
		-DBUILD_QT=OFF
		-DBUILD_SDL=OFF

		# Disable ARM architecture-based debugging.
		-DUSE_CLI_DEBUGGER=OFF
		-DUSE_GDB_STUB=OFF

		# Set USE flag-dependent options.
		-DUSE_EPOXY=$(usex epoxy ON OFF)
		-DUSE_FFMPEG=$(usex ffmpeg ON OFF)
		-DBUILD_GLES2=$(usex gles2 ON OFF)
		-DUSE_MAGICK=$(usex imagemagick ON OFF)
		-DBUILD_LTO=$(usex lto ON OFF)
		-DBUILD_GL=$(usex opengl ON OFF)
		-DBUILD_PGO=$(usex pgo ON OFF)
		-DPGO_STAGE_2=$(usex pgopost ON OFF)
		-DUSE_PNG=$(usex png ON OFF)
		-DUSE_LIBZIP=$(usex zip ON OFF)
		-DUSE_ZLIB=$(usex zlib ON OFF)
	)
	cmake-utils_src_configure
}

src_install() {
	# Install the mGBA Libretro core.
	cmake-utils_src_install

	# Install the mGBA Libretro info file and enforce games-specific security
	libretro-core_src_install
}
