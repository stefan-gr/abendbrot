# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit libretro

DESCRIPTION="Collection of commonly used Cg shaders."
HOMEPAGE="https://github.com/libretro/common-shaders"
SRC_URI=""

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="git://github.com/libretro/common-shaders.git"
	KEYWORDS=""
else
	KEYWORDS="amd64 x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="+cg"

RDEPEND=""
DEPEND="${RDEPEND}
		!cg? ( games-emulation/retroarch[-cg]
				media-gfx/nvidia-cg-toolkit )"

src_install() {
	dodir "${LIBRETRO_DATA_DIR}"/shaders
	# Remove unnecessary git files
	rm -r .git
	# Install plain CG shaders
	use cg && cp -R "${S}"/* "${D}${LIBRETRO_DATA_DIR}"/shaders/
	if ! use cg; then
		# Copy misc files not covered by the converter script
		OIFS="$IFS"
		IFS=$'\n'
		for f in $(find . -type f ! -iname "*.cg*") ; do
			cp --parents "${f}" "${D}${LIBRETRO_DATA_DIR}"/shaders/
		done
		IFS="$OIFS"
		"${GAMES_BINDIR}"/retroarch-cg2glsl "${S}" "${D}${LIBRETRO_DATA_DIR}"/shaders/
		elog "Converted CG shaders to glsl"
	fi
	prepgamesdirs
}
