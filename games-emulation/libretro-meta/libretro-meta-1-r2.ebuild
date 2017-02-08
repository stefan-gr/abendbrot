# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"

DESCRIPTION="Meta package for various libretro implementations"
HOMEPAGE="http://www.libretro.com/"
LICENSE="metapackage"
SLOT="0"
IUSE="+2048 +4do +beetle-psx bnes +bsnes craft +desmume dolphin +fbalpha fbalpha2012 fceumm +gambatte +genplus \
+handy mame mame2000 mednafen-gba +mednafen-ngp +mednafen-pce-fast \
mednafen-snes +mednafen-vb +mednafen-wswan meteor +mgba +mupen64plus +nestopia +nxengine \
pcsx-rearmed +mednafen-supergrafx picodrive ppsspp +prboom +prosystem +psp1 quicknes +reicast +scummvm \
snes9x snes9x2002 snes9x2010 +stella tgbdual +tyrquake vba-next vbam +yabause"

KEYWORDS="amd64 x86"

RDEPEND="2048? ( >=games-emulation/2048-libretro-1.0_pre20170119 )
		4do? ( >=games-emulation/4do-libretro-1.0_pre20170124 )
		beetle-psx? ( >=games-emulation/beetle-psx-libretro-1.0_pre20170124 )
		bnes? ( >=games-emulation/bnes-libretro-1.0_pre20161222 )
		bsnes? ( >=games-emulation/bsnes-libretro-1.0_pre20170124 )
		craft? ( >=games-emulation/craft-libretro-1.0_pre20170119 )
		desmume? ( >=games-emulation/desmume-libretro-1.0_pre20170124 )
		dolphin? ( games-emulation/dolphin-libretro )
		fbalpha? ( >=games-emulation/fbalpha-libretro-1.0_pre20170124 )
		fbalpha2012? ( >=games-emulation/fbalpha2012-libretro-libretro-1.0_pre20170124 )
		fceumm? ( || ( >=games-emulation/fceumm-libretro-1.0_pre20170124 games-emulation/fceu-next-libretro ) )
		gambatte? ( >=games-emulation/gambatte-libretro-1.0_pre20170124 )
		genplus? ( >=games-emulation/genplus-libretro-1.0_pre20170124 )
		handy? ( >=games-emulation/handy-libretro-1.0_pre20170124 )
		mame2000? ( >=games-emulation/mame2000-libretro-1.0_pre20170124 )
		mame? ( >=games-emulation/mame-libretro-1.0_pre20170124 )
		mednafen-gba? ( >=games-emulation/mednafen-gba-libretro-1.0_pre20170125 )
		mednafen-ngp? ( >=games-emulation/mednafen-ngp-libretro-1.0_pre20170124 )
		mednafen-pce-fast? ( >=games-emulation/mednafen-pce-fast-libretro-1.0_pre20170124 )
		mednafen-snes? ( >=games-emulation/mednafen-snes-libretro-1.0_pre20170124 )
		mednafen-supergrafx? ( >=games-emulation/mednafen-supergrafx-libretro-1.0_pre20170124 )
		mednafen-vb? ( >=games-emulation/mednafen-vb-libretro-1.0_pre20170124 )
		mednafen-wswan? ( >=games-emulation/mednafen-wswan-libretro-1.0_pre20170124 )
		meteor? ( >=games-emulation/meteor-libretro-1.0_pre20170124 )
		mgba? ( || ( >=games-emulation/mgba-libretro-1.0_pre20170124 >=games-emulation/mgba-libretro-cheevo-1.0_pre20170124 ) )
		mupen64plus? ( >=games-emulation/mupen64plus-libretro-1.0_pre20170125 )
		nestopia? ( >=games-emulation/nestopia-libretro-1.0_pre20170125 )
		nxengine? ( >=games-emulation/nxengine-libretro-1.0_pre20170124 )
		pcsx-rearmed? ( >=games-emulation/pcsx-rearmed-libretro-1.0_pre20170124 )
		picodrive? ( >=games-emulation/picodrive-libretro-1.0_pre20161209 )
		ppsspp? ( >=games-emulation/ppsspp-libretro-1.0_pre20161215 )
		prboom? ( >=games-emulation/prboom-libretro-1.0_pre20170125 )
		prosystem? ( >=games-emulation/prosystem-libretro-1.0_pre20170124 )
		psp1? ( >=games-emulation/psp1-libretro-1.0_pre20160803 )
		quicknes? ( >=games-emulation/quicknes-libretro-1.0_pre20170124 )
		reicast? ( >=games-emulation/reicast-libretro-1.0_pre20170123 )
		scummvm? ( >=games-emulation/scummvm-libretro-1.0_pre20170124 )
		snes9x2002? ( >=games-emulation/snes9x2002-libretro-1.0_pre20170125 )
		snes9x2010? ( >=games-emulation/snes9x2010-libretro-1.0_pre20170125 )
		snes9x? ( >=games-emulation/snes9x-libretro-1.0_pre20170123 )
		stella? ( >=games-emulation/stella-libretro-1.0_pre20170124 )
		tgbdual? ( >=games-emulation/tgbdual-libretro-1.0_pre20170124 )
		tyrquake? ( >=games-emulation/tyrquake-libretro-1.0_pre20170124 )
		vba-next? ( >=games-emulation/vba-next-libretro-1.0_pre20170123 )
		vbam? ( >=games-emulation/vbam-libretro-1.0_pre20161215 )
		yabause? ( >=games-emulation/yabause-libretro-1.0_pre20170124 )"
DEPEND=""
