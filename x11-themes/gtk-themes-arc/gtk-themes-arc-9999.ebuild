# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3 autotools

DESCRIPTION="A flat theme with transparent elements for GTK+2, GTK+3, gnome-shell and xfce4"
HOMEPAGE="https://github.com/horst3180/Arc-theme"
SRC_URI=""
EGIT_REPO_URI="git://github.com/horst3180/Arc-theme.git"
LICENSE="GPL-3"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-3.14.9
	>=x11-themes/gtk-engines-murrine-0.98.2-r1"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog README.md
	#installing chrome themes
	insinto /usr/share/themes/Arc/Chrome/
	doins extra/Chrome/arc-theme.crx
	insinto /usr/share/themes/Arc-Dark/Chrome/
	doins extra/Chrome/arc-darker-theme.crx
}

pkg_preinst() {
	if ! has_version "=${CATEGORY}/${P}"; then
		first_install="1"
	fi
}

pkg_postinst() {
	if [[ "${first_install}" == "1" ]]; then
		ewarn ""
		ewarn "This theme provides custom themes for chrome/chromium."
		ewarn "You can find them in the respective theme directoy."
		ewarn "Example:"
		ewarn "/usr/share/themes/Arc/Chrome/arc-theme.crx"
		ewarn "Drag&Drop it in your running chrome/chromium browser window to install it."
		ewarn ""
	fi
}
