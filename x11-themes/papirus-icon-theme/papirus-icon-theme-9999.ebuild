# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3 gnome2-utils

DESCRIPTION="Modified and adaptive Paper icon theme for KDE"
HOMEPAGE="https://github.com/varlesh/papirus-icon-theme"
SRC_URI=""
EGIT_REPO_URI="git://github.com/varlesh/papirus-icon-theme.git"
LICENSE="CC-BY-SA-4.0"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="kde-plasma/breeze:5
	kde-apps/oxygen-icons:5"
RDEPEND="${DEPEND}"

src_install() {
    insinto /usr/share/icons/
    doins -r papirus-dark
    doins -r papirus
    dodoc README.md
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }