# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

DESCRIPTION="libretro implementation of NXEngine. (Cave Story)"
HOMEPAGE="https://github.com/libretro/nxengine-libretro"
SRC_URI=""

EGIT_REPO_URI="https://github.com/libretro/nxengine-libretro.git"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+cave_story"

RDEPEND=""
DEPEND=""

src_prepare() {
	git-r3_fetch https://github.com/libretro/libretro-super.git HEAD 
	git-r3_checkout https://github.com/libretro/libretro-super.git \
		"${WORKDIR}"/infos
	git-r3_checkout
}

src_install() {
	insinto /usr/$(get_libdir)/libretro
	doins "${S}"/nxengine_libretro.so
	doins "${WORKDIR}"/infos/dist/info/nxengine_libretro.info
	if use cave_story; then
		insinto /usr/share/libretro/nxengine_libretro/datafiles/
		doins "${S}"/datafiles/Doukutsu.exe
		cp -R "${S}"/datafiles/data "${D}/usr/share/libretro/nxengine_libretro/datafiles/" || die "Install failed!"
	fi
}

pkg_postinst() {
	if use cave_story; then
		elog "To play the included Cave Story game symlink"
		elog "/usr/share/libretro/nxengine_libretro/datafiles/"
		elog "to your rgui_browser_directory and use Doukutsu.exe as game"
	fi
}
