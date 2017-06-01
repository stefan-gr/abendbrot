# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_COMMIT_SHA="8f2ed34b6e7da37e0086d6ca8cc0fe9a8db0c3ee"
inherit libretro

DESCRIPTION="Collection of commonly used Cg shaders."
HOMEPAGE="https://github.com/libretro/common-shaders"
KEYWORDS="amd64 x86"

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
	[[ ! ${PV} == "1.0_pre"* ]] && rm -r .git
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
		"${EROOT}"usr/bin/retroarch-cg2glsl "${S}" "${D}${LIBRETRO_DATA_DIR}"/shaders/ || die "Shader conversion failed!"
		elog "Converted CG shaders to glsl"
	fi
}
