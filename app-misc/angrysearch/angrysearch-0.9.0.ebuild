# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
PYTHON_REQ_USE="sqlite"
PYTHON_COMPAT=( python{3_3,3_4} )

inherit eutils python-single-r1

DESCRIPTION="Linux file search, instant results as you type"
HOMEPAGE="https://github.com/DoTheEvo/ANGRYsearch"
SRC_URI="https://github.com/DoTheEvo/ANGRYsearch/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+python_single_target_python3_3 python_single_target_python3_4"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"
DEPEND=""
RDEPEND="${DEPEND}
	${PYTHON_DEPS}
	>=dev-python/PyQt5-5.4.1[${PYTHON_USEDEP},gui]
	>=sys-apps/mlocate-0.26-r1
	>=app-admin/sudo-1.8.12"

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
