# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools rpm

DESCRIPTION="Epson Inkjet Printer Driver (ESC/P-R) for Linux"
HOMEPAGE="http://download.ebz.epson.net/dsc/search/01/search/?OSC=LX"
SRC_URI="mirror://debian/pool/main/e/${PN}/${PN}_${PV}.orig.tar.gz"
RESTRICT="primaryuri"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-print/cups"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
}
