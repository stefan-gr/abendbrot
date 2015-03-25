# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

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
DEPEND=""

src_unpack() {
	git-r3_fetch https://github.com/libretro/libretro-super.git HEAD
	git-r3_checkout https://github.com/libretro/libretro-super.git \
		"${WORKDIR}"/infos
	git-r3_fetch
	git-r3_checkout
}

src_compile() {
	myemakeargs=(
		$(usex profile_accuracy "profile=accuracy" "")
		$(usex profile_balanced "profile=balanced" "")
		$(usex profile_performance "profile=performance" "")
	)
	emake "${myemakeargs[@]}" -f makefile.libretro || die "emake failed"
}

src_install() {
	insinto /usr/$(get_libdir)/libretro
	doins "${S}"/fb_alpha_libretro.so
	insinto /usr/share/libretro/info/
	doins "${WORKDIR}"/infos/dist/info/fb_alpha_libretro.info
	insinto /usr/share/libretro/fb_alpha_libretro
	doins "${S}"/src/license.txt
}
