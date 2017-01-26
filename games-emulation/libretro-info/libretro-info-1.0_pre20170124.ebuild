# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

LIBRETRO_REPO_NAME="libretro/libretro-super"
LIBRETRO_COMMIT_SHA="3bccca027af2d9cbb964e5439cf6da9a53c86d6b"
inherit libretro

DESCRIPTION="Libretro info files required for libretro cores"
HOMEPAGE="https://github.com/libretro/libretro-super"
KEYWORDS="~amd64 ~x86 ~arm"

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
