# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

# @ECLASS: libretro.eclass
# @MAINTAINER:
# leycec@gmail.com
# @AUTHOR:
# Original author: Cecil Curry
# @BLURB: An eclass to streamline the construction of Libretro-related ebuilds
# @DESCRIPTION:
# The libretro eclass is designed to streamline the construction of
# ebuilds for Libretro-related ebuilds, including those for both low-level
# Libretro cores and assets as well for Libretro and Retroarch themselves.

inherit games

# @ECLASS-VARIABLE: LIBRETRO_LIB_DIR
# @DESCRIPTION:
# Absolute path of the directory containing Libretro shared libraries.
LIBRETRO_LIB_DIR=${GAMES_PREFIX}/"$(get_libdir)"/libretro

# @ECLASS-VARIABLE: RETROARCH_LIB_DIR
# @DESCRIPTION:
# Absolute path of the directory containing Retroarch shared libraries.
RETROARCH_LIB_DIR=${GAMES_PREFIX}/"$(get_libdir)"/retroarch

# @ECLASS-VARIABLE: LIBRETRO_DATA_DIR
# @DESCRIPTION:
# Absolute path of the directory containing Libretro data files.
LIBRETRO_DATA_DIR=${GAMES_DATADIR}/libretro

# @ECLASS-VARIABLE: RETROARCH_DATA_DIR
# @DESCRIPTION:
# Absolute path of the directory containing Retroarch data files.
RETROARCH_DATA_DIR=${GAMES_DATADIR}/retroarch
