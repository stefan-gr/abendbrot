# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
XORG_EAUTORECONF="yes"
XORG_MULTILIB="yes"

if [[ ${PV} = *9999* ]]; then
	GIT_ECLASS="git-r3"
	EXPERIMENTAL="true"
	EGIT_REPO_URI="git://github.com/xkbcommon/${PN}"
else
	XORG_BASE_INDIVIDUAL_URI=""
	SRC_URI="http://xkbcommon.org/download/${P}.tar.xz"
fi

inherit xorg-2 ${GIT_ECLASS}

DESCRIPTION="X.Org xkbcommon library"
KEYWORDS=""
IUSE="doc x11"

DEPEND="sys-devel/bison
	sys-devel/flex
	x11-proto/xproto[${MULTILIB_USEDEP}]
	>=x11-proto/kbproto-1.0.5[${MULTILIB_USEDEP}]
	doc? ( app-doc/doxygen )
	x11? ( x11-libs/libxcb[xkb] )"
RDEPEND=""

XORG_CONFIGURE_OPTIONS=(
	--with-xkb-config-root="${EPREFIX}/usr/share/X11/xkb" $(use_with doc doxygen) $(use_enable x11)
)
