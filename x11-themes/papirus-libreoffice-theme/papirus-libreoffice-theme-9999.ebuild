# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="Papirus theme for Libreoffice"
HOMEPAGE="https://github.com/PapirusDevelopmentTeam/papirus-libreoffice-theme"
SRC_URI=""
EGIT_REPO_URI="https://github.com/PapirusDevelopmentTeam/papirus-libreoffice-theme.git"
LICENSE="GPL-3"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	emake PREFIX="/usr/$(get_libdir)" DESTDIR="${D}" install
	einstalldocs
}
