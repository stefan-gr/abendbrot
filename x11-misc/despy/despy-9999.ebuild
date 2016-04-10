# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit qmake-utils git-r3

DESCRIPTION="A DSP (styleproject) settings manager"
HOMEPAGE="Small window'o'widgets for previewing DSP settings."
SRC_URI=""
EGIT_REPO_URI="git://github.com/magpie240/despy.git"

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
	dobin despy
}
