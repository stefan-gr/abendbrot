# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit qmake-utils eutils

DESCRIPTION="A clone of Media Player Classic reimplimented in Qt"
HOMEPAGE="https://github.com/cmdrkotori/mpc-qt"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/cmdrkotori/mpc-qt.git"
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="https://github.com/cmdrkotori/mpc-qt/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"

DEPEND=">=media-video/mpv-0.18.0:0[libmpv]
		dev-qt/qtx11extras:5
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtnetwork:5
		dev-qt/qtwidgets:5"
RDEPEND="${DEPEND}"

src_configure() {
	eqmake5
}

src_install() {
	dobin mpc-qt
	insinto /usr/share/pixmaps
	newins images/bitmaps/icon.png "${PN}.png"
	make_desktop_entry "mpc-qt %U" "Media Player Classic Qute Theater" "${PN}" "AudioVideo;Audio;Video;Player;TV;" "MimeType=application/ogg;application/x-ogg;application/sdp;application/smil;application/x-smil;application/streamingmedia;application/x-streamingmedia;application/vnd.rn-realmedia;application/vnd.rn-realmedia-vbr;audio/aac;audio/x-aac;audio/m4a;audio/x-m4a;audio/mp1;audio/x-mp1;audio/mp2;audio/x-mp2;audio/mp3;audio/x-mp3;audio/mpeg;audio/x-mpeg;audio/mpegurl;audio/x-mpegurl;audio/mpg;audio/x-mpg;audio/rn-mpeg;audio/ogg;audio/scpls;audio/x-scpls;audio/vnd.rn-realaudio;audio/wav;audio/x-pn-windows-pcm;audio/x-realaudio;audio/x-pn-realaudio;audio/x-ms-wma;audio/x-pls;audio/x-wav;video/mpeg;video/x-mpeg;video/x-mpeg2;video/mp4;video/msvideo;video/x-msvideo;video/ogg;video/quicktime;video/vnd.rn-realvideo;video/x-ms-afs;video/x-ms-asf;video/x-ms-wmv;video/x-ms-wmx;video/x-ms-wvxvideo;video/x-avi;video/x-fli;video/x-flv;video/x-theora;video/x-matroska;video/webm;audio/x-flac;audio/x-vorbis+ogg;video/x-ogm+ogg;audio/x-shorten;audio/x-ape;audio/x-wavpack;audio/x-tta;audio/AMR;audio/ac3;video/mp2t;audio/flac;audio/mp4;"
}
