# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="Library to handle RPG Maker 2000/2003 and EasyRPG projects"
HOMEPAGE="https://easyrpg.org/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/EasyRPG/liblcf.git"
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="https://github.com/EasyRPG/liblcf/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 x86"
fi

LICENSE="MIT"
SLOT="0"

DEPEND="dev-libs/expat
	dev-libs/icu"
RDEPEND="${DEPEND}"

src_prepare() {
	default_src_prepare
	eautoreconf
}
