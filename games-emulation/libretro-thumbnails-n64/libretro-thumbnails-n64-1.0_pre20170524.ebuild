# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
S="${WORKDIR}"/Nintendo\ -\ Nintendo\ 64

DESCRIPTION="Repository containing content data files for boxarts, thumbnails and screenshots."
SRC_URI="http://thumbnailpacks.libretro.com/Nintendo%20-%20Nintendo%2064.zip"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-3"
SLOT="0"

DEPEND="app-arch/unzip"
RDEPEND="${DEPEND}"

LIBRETRO_DATA_DIR="/usr/share/libretro/thumbnails"

src_install() {
	dodir "${LIBRETRO_DATA_DIR}"
	cp -R "${WORKDIR}"/* "${D}${LIBRETRO_DATA_DIR}" || die "Install failed!"
}

