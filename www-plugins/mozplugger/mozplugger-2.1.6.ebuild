# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit eutils

DESCRIPTION="Streaming media plugin for Mozilla, based on netscape-plugger"
HOMEPAGE="http://mozplugger.mozdev.org/"
SRC_URI="http://mozplugger.mozdev.org/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="x11-libs/libX11"
RDEPEND="${DEPEND}"

src_install() {
	exeinto /usr/bin
	doexe mozplugger-{helper,controller,linker,update}
	insinto /etc
	doins mozpluggerrc
	insinto /usr/$(get_libdir)/nsbrowser/plugins
	doins mozplugger.so
	dodoc ChangeLog README mozplugger.7
}
