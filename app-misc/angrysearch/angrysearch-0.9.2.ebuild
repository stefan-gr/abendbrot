# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"
PYTHON_REQ_USE="sqlite"
PYTHON_COMPAT=( python{3_4,3_5} )

inherit eutils python-single-r1

DESCRIPTION="Linux file search, instant results as you type"
HOMEPAGE="https://github.com/DoTheEvo/ANGRYsearch"
SRC_URI="https://github.com/DoTheEvo/ANGRYsearch/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+python_single_target_python3_4 python_single_target_python3_5"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"
DEPEND="${PYTHON_DEPS}
	>=dev-python/PyQt5-5.4.1[${PYTHON_USEDEP},gui]
	>=app-admin/sudo-1.8.12
	>=x11-libs/libxkbcommon-0.5.0
	>=x11-misc/xdg-utils-1.1.0_rc2"
RDEPEND="${DEPEND}
	dev-python/pip[${PYTHON_USEDEP}]"

DOCS=( README.md )

S="${WORKDIR}/ANGRYsearch-${PV}"

src_prepare() {
	sed -i angrysearch.desktop \
		-e "s:Exec=python /usr/share/angrysearch/angrysearch.py:Exec=angrysearch.py:" \
		|| die
}

src_install() {
	exeinto /usr/bin/
	doexe angrysearch.py
	python_fix_shebang "${ED}"usr/bin/angrysearch.py
	insinto /usr/share/applications/
	doins angrysearch.desktop
	insinto /usr/share/pixmaps/
	doins angrysearch.svg
}

pkg_postinst() {
	ewarn ""
	ewarn "You need to install scandir through pip to have search functionality, to do so do the following:"
	ewarn "\$ pip3 install scandir"
	ewarn ""
}
