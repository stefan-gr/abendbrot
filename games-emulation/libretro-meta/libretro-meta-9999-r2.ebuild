# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

DESCRIPTION="Meta package for various libretro implementations"
HOMEPAGE="http://www.libretro.com/"
LICENSE="metapackage"
SLOT="0"
IUSE="+2048 +beetle-psx +beetle-saturn bnes +bsnes bsnes2014 bsnes-cpp98 bsnes-mercury citra craft +desmume +dolphin duckstation \
easyrpg fbalpha2012 +fbneo fceumm +flycast +gambatte +genplus +handy kronos mame mame2000 mame2003 +mame2003-plus mame2016 mednafen-gba \
+mednafen-ngp +mednafen-pce-fast mednafen-snes +mednafen-vb +mednafen-wswan melonds meowpc98 mesen mesen-s meteor +mgba mrboom +mupen64plus \
+nestopia +nxengine openlara +opera pcsx-rearmed +mednafen-supergrafx parallel-n64 picodrive +ppsspp +prboom +prosystem px68k quicknes \
redream sameboy +scummvm snes9x snes9x2002 snes9x2010 stella2014 +stella tgbdual +tyrquake vba-next vbam yabasanshiro yabause"

KEYWORDS=""

RDEPEND="2048? ( >=games-emulation/2048-libretro-9999 )
		beetle-psx? ( >=games-emulation/beetle-psx-libretro-9999 )
		beetle-saturn? ( >=games-emulation/beetle-saturn-libretro-9999 )
		bnes? ( >=games-emulation/bnes-libretro-9999 )
		bsnes? ( >=games-emulation/bsnes-libretro-9999 )
		bsnes2014? ( >=games-emulation/bsnes2014-libretro-9999 )
		bsnes-cpp98? ( >=games-emulation/bsnes-libretro-cplusplus98-9999 )
		bsnes-mercury? ( >=games-emulation/bsnes-mercury-libretro-9999 )
		citra? ( >=games-emulation/citra-libretro-9999 )
		craft? ( >=games-emulation/craft-libretro-9999 )
		desmume? ( >=games-emulation/desmume-libretro-9999 )
		dolphin? ( >=games-emulation/dolphin-libretro-9999 )
		duckstation? ( >=games-emulation/duckstation-libretro-9999 )
		easyrpg? ( >=games-emulation/easyrpg-libretro-9999 )
		fbalpha2012? ( >=games-emulation/fbalpha2012-libretro-9999 )
		fbneo? ( >=games-emulation/fbneo-libretro-9999 )
		fceumm? ( >=games-emulation/fceumm-libretro-9999 )
		flycast? ( >=games-emulation/flycast-libretro-9999 )
		gambatte? ( >=games-emulation/gambatte-libretro-9999 )
		genplus? ( >=games-emulation/genplus-libretro-9999 )
		handy? ( >=games-emulation/handy-libretro-9999 )
		kronos? ( >=games-emulation/kronos-libretro-9999 )
		mame? ( >=games-emulation/mame-libretro-9999 )
		mame2000? ( >=games-emulation/mame2000-libretro-9999 )
		mame2003? ( >=games-emulation/mame2003-libretro-9999 )
		mame2003-plus? ( >=games-emulation/mame2003-plus-libretro-9999 )
		mame2016? ( >=games-emulation/mame2016-libretro-9999 )
		mesen? ( >=games-emulation/mesen-libretro-9999 )
		mesen-s? ( >=games-emulation/mesen-s-libretro-9999 )
		mednafen-gba? ( >=games-emulation/mednafen-gba-libretro-9999 )
		mednafen-ngp? ( >=games-emulation/mednafen-ngp-libretro-9999 )
		mednafen-pce-fast? ( >=games-emulation/mednafen-pce-fast-libretro-9999 )
		mednafen-snes? ( >=games-emulation/mednafen-snes-libretro-9999 )
		mednafen-supergrafx? ( >=games-emulation/mednafen-supergrafx-libretro-9999 )
		mednafen-vb? ( >=games-emulation/mednafen-vb-libretro-9999 )
		mednafen-wswan? ( >=games-emulation/mednafen-wswan-libretro-9999 )
		melonds? ( >=games-emulation/melonds-libretro-9999 )
		meowpc98? ( >=games-emulation/meowpc98-libretro-9999 )
		meteor? ( >=games-emulation/meteor-libretro-9999 )
		mgba? ( || ( >=games-emulation/mgba-libretro-9999 >=games-emulation/mgba-libretro-cheevo-9999 ) )
		mrboom? ( >=games-emulation/mrboom-libretro-9999 )
		mupen64plus? ( >=games-emulation/mupen64plus-libretro-9999 )
		nestopia? ( >=games-emulation/nestopia-libretro-9999 )
		nxengine? ( >=games-emulation/nxengine-libretro-9999 )
		openlara? ( >=games-emulation/openlara-libretro-9999 )
		opera? ( >=games-emulation/opera-libretro-9999 )
		parallel-n64? ( >=games-emulation/parallel-n64-libretro-9999 )
		pcsx-rearmed? ( >=games-emulation/pcsx-rearmed-libretro-9999 )
		picodrive? ( >=games-emulation/picodrive-libretro-9999 )
		snes9x2002? ( >=games-emulation/snes9x2002-libretro-9999 )
		ppsspp? ( >=games-emulation/ppsspp-libretro-9999 )
		prboom? ( >=games-emulation/prboom-libretro-9999 )
		prosystem? ( >=games-emulation/prosystem-libretro-9999 )
		px68k? ( >=games-emulation/px68k-libretro-9999 )
		quicknes? ( >=games-emulation/quicknes-libretro-9999 )
		redream? ( >=games-emulation/redream-libretro-9999 )
		sameboy? ( >=games-emulation/sameboy-libretro-9999 )
		scummvm? ( >=games-emulation/scummvm-libretro-9999 )
		snes9x? ( >=games-emulation/snes9x-libretro-9999 )
		snes9x2010? ( >=games-emulation/snes9x2010-libretro-9999 )
		stella2014? ( >=games-emulation/stella2014-libretro-9999 )
		stella? ( >=games-emulation/stella-libretro-9999 )
		tgbdual? ( >=games-emulation/tgbdual-libretro-9999 )
		tyrquake? ( >=games-emulation/tyrquake-libretro-9999 )
		vba-next? ( >=games-emulation/vba-next-libretro-9999 )
		vbam? ( >=games-emulation/vbam-libretro-9999 )
		yabasanshiro? ( >=games-emulation/yabasanshiro-libretro-9999 )
		yabause? ( >=games-emulation/yabause-libretro-9999 )"
DEPEND=""
