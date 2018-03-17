# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="A Dreamcast Emulator"
HOMEPAGE="http://reicast.com/"
EGIT_REPO_URI="https://github.com/reicast/reicast-emulator.git"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""
REQUIRED_USE=""
S="${S}/shell/linux"

DEPEND="media-libs/alsa-lib
media-libs/mesa[egl,gles2]"
RDEPEND="${DEPEND}
dev-python/python-evdev"

src_install() {
  emake DESTDIR="${D}" PREFIX="/usr" install
}
