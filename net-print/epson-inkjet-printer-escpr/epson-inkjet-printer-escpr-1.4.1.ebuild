# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools rpm

DESCRIPTION="Epson Inkjet Printer Driver (ESC/P-R) for Linux"
HOMEPAGE="http://download.ebz.epson.net/dsc/search/01/search/?OSC=LX"
#SRC_URI="https://download2.ebz.epson.net/dsc/f/03/00/02/90/17/f56ca75bf934fba0fed23a99271dfbaefe363bae/${P}-1lsb3.2.src.rpm"
SRC_URI="http://ftp.uk.debian.org/debian/pool/main/e/epson-inkjet-printer-escpr/epson-inkjet-printer-escpr_1.4.1.orig.tar.gz"
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


