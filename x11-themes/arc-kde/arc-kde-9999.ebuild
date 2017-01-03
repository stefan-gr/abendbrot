# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit git-r3

DESCRIPTION="Arc cusomization for Plasma 5 "
HOMEPAGE="https://github.com/PapirusDevelopmentTeam/arc-kde"
SRC_URI=""
EGIT_REPO_URI="https://github.com/PapirusDevelopmentTeam/arc-kde.git"
LICENSE="GPL-3"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	insinto /usr/share
	doins -r Kvantum aurorae color-schemes konsole konversation plasma wallpapers yakuake
}

pkg_postinst() {
	elog ""
	elog "This theme optionally supports \"x11-themes/kvantum\""
	elog "See also \"x11-themes/gtk-themes-arc\" for gtk support"
	elog ""
}
