# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 autotools

DESCRIPTION="Official continuation of Ceti for Gnome 3.14 and 3.16"
HOMEPAGE="https://github.com/horst3180/Ceti-2-theme"
SRC_URI=""
EGIT_REPO_URI="https://github.com/horst3180/Ceti-2-theme.git"
LICENSE="GPL-3"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-3.14.9
	>=x11-themes/gtk-engines-murrine-0.98.2-r1"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
	default_src_prepare
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog README.md
	#installing chrome theme
	insinto /usr/share/themes/Ceti-2/Chrome/
	doins extra/Chrome/Ceti-2-chrome.crx
}

pkg_preinst() {
	if ! has_version "=${CATEGORY}/${P}"; then
		first_install="1"
	fi
}

pkg_postinst() {
	if [[ "${first_install}" == "1" ]]; then
		ewarn ""
		ewarn "This theme provides a custom theme for chrome/chromium."
		ewarn "You can find it in the respective theme directoy."
		ewarn "Example:"
		ewarn "/usr/share/themes/Ceti-2/Chrome/Ceti-2-chrome.crx"
		ewarn "Drag&Drop it in your running chrome/chromium browser window to install it."
		ewarn ""
	fi
}
