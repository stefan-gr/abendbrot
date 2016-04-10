# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils qmake-utils git-r3

DESCRIPTION="A DSP (styleproject) settings manager"
HOMEPAGE="https://github.com/magpie240/dspconfig"
SRC_URI=""
EGIT_REPO_URI="git://github.com/magpie240/dspconfig.git"

LICENSE=""
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE=""

DEPEND="x11-themes/styleproject[qt5]
	dev-qt/qtwidgets:5"
RDEPEND="${DEPEND}"

src_configure() {
	eqmake5
	default_src_configure
}

src_install() {
	dobin dspconfig
	make_desktop_entry dspconfig "DSP Manager" "preferences-system" "Qt;KDE;Settings;"
}

pkg_preinst() {
	if ! has_version "=${CATEGORY}/${PN}-${PVR}"; then
		first_install="1"
	fi
}

pkg_postinst() {
	if [[ "${first_install}" == "1" ]]; then
		elog ""
		elog "To make the Demo button work, you need to instal x11-misc/despy"
		elog ""
		ewarn "This message will only be displayed once!"
		ewarn ""
	fi
}
