# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="Breath Theme for Manjaro Linux (Plasma 5)"
HOMEPAGE="https://github.com/manjaro/artwork-breath"
SRC_URI="https://github.com/manjaro/artwork-breath/archive/e5fe022165df820179fd621ad1e0680906cb4122.tar.gz -> ${P}.tar.gz"
RESTRICT="primaryuri"
S="${WORKDIR}/artwork-breath-e5fe022165df820179fd621ad1e0680906cb4122"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
