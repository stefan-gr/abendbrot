# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="Maia plasma theme collection (Manjaro)"
HOMEPAGE="https://github.com/manjaro/artwork-maia"
SRC_URI="https://github.com/manjaro/artwork-maia/archive/7d8bf6800dd8898aaba97cbde7fabb70d0792b35.tar.gz -> ${P}.tar.gz"
RESTRICT="primaryuri"
S="${WORKDIR}/artwork-maia-7d8bf6800dd8898aaba97cbde7fabb70d0792b35"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
