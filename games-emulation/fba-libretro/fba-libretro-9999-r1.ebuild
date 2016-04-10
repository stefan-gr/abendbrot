# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit libretro-core

DESCRIPTION="libretro implementation of Final Burn Alpha (FBA). (Arcade)"
HOMEPAGE="https://github.com/libretro/fba-libretro"
SRC_URI=""

EGIT_REPO_URI="https://github.com/libretro/libretro-fba.git"

LICENSE="FBA"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~arm"
IUSE="+profile_accuracy profile_balanced profile_performance"

REQUIRED_USE="^^ ( profile_accuracy profile_balanced profile_performance )"

RDEPEND=""
DEPEND="${RDEPEND}"

src_compile() {
	myemakeargs=(
		$(usex profile_accuracy "profile=accuracy" "")
		$(usex profile_balanced "profile=balanced" "")
		$(usex profile_performance "profile=performance" "")
	)
	emake "${myemakeargs[@]}" -f makefile.libretro || die "emake failed"
}
