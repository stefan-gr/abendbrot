# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit libretro-core

DESCRIPTION="libretro implementation of Final Burn Alpha (FBA). (Arcade)"
HOMEPAGE="https://github.com/libretro/fba-libretro"
SRC_URI=""

EGIT_REPO_URI="https://github.com/libretro/libretro-fba.git"
if [[ ${PV} == 9999 ]]; then
	KEYWORDS=""
else
	EGIT_COMMIT_DATE="${PV:7:4}-${PV:11:2}-${PV:13:2}"
	KEYWORDS="amd64 x86 arm"
fi

LICENSE="FBA"
SLOT="0"
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
