# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils autotools

DESCRIPTION="X Neko Project II, a PC-9801 emulator (PC98)"
HOMEPAGE="http://www.nonakap.org/np2/"
LICENSE="BSD"

SLOT="0"

IUSE=""

DEPEND="x11-libs/gtk+:2
		media-libs/sdl2-mixer"
RDEPEND="${DEPEND}"

if [[ ${PV} == 9999 ]]; then
	inherit subversion

	ESVN_REPO_URI="http://amethyst.yui.ne.jp/svn/pc98/np2/trunk/"
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="http://www.nonakap.org/np2/release/${P}.tar.bz2"
	KEYWORDS="amd64 x86"
fi

src_prepare(){
	# subversion clones the repo into ${S}, that's why we change directories manually
	cd "${S}/x11"
	default_src_prepare
	eautoreconf
}

src_configure(){
	cd "${S}/x11"
	econf --enable-build-all
}

src_compile(){
	cd "${S}/x11"
	default_src_compile
}

src_install(){
	cd "${S}/x11"
	default_src_install
	newicon ../android-project/res/drawable-mdpi/ic_launcher.png xnp2.png
	make_desktop_entry xnp2 "Neko Project II" xnp2
	make_desktop_entry xnp21 "Neko Project II + IA32" xnp2
}
