# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_REPO_NAME="libretro/libretro-super"
LIBRETRO_COMMIT_SHA="7989f46e375e8a344b1f2fe551eca82f90a279fc"
inherit libretro

DESCRIPTION="Libretro info files required for libretro cores"
HOMEPAGE="https://github.com/libretro/libretro-super"
KEYWORDS="amd64 x86"

LICENSE="GPL-3"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	:
}

src_install() {
	insinto "${LIBRETRO_DATA_DIR}"/info
	doins dist/info/*.info
}
