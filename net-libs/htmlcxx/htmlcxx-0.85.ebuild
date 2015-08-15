# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: net-libs/htmlcxx-0.85.ebuild,v 1.0 2013/04/28 10:15:41 by frostwork Exp $

EAPI="4"

inherit eutils

DESCRIPTION="a simple non-validating css1 and html parser for C++"
HOMEPAGE="http://sf.net/projects/${PN}"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-ptrdiff_t.patch
}
