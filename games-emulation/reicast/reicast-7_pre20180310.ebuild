# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

COMMIT="b4631f6715ab7ee8483ebcef37a97f6e3194602e"

DESCRIPTION="A Dreamcast Emulator"
HOMEPAGE="http://reicast.com/"
SRC_URI="https://github.com/reicast/reicast-emulator/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
REQUIRED_USE=""
S="${WORKDIR}/${PN}-emulator-${COMMIT}/shell/linux"

DEPEND="media-libs/alsa-lib
media-libs/mesa[egl,gles2]"
RDEPEND="${DEPEND}
dev-python/python-evdev"

src_install() {
  emake DESTDIR="${D}" PREFIX="/usr" install
}
