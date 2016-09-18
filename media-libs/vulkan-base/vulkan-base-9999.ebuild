# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit git-r3

DESCRIPTION="Official Vulkan headerfiles, loader, validation layers and sample binaries"
HOMEPAGE="https://vulkan.lunarg.com"
SRC_URI=""
EGIT_REPO_URI="https://github.com/KhronosGroup/Vulkan-LoaderAndValidationLayers.git"

LICENSE="MIT"
IUSE="headers layers tools"
SLOT="0"

KEYWORDS="~amd64"

DEPEND="dev-util/cmake
	>=dev-lang/python-3"

src_unpack() {
	if use tools ; then
		git-r3_fetch "https://github.com/KhronosGroup/glslang.git"
		git-r3_fetch "https://github.com/KhronosGroup/SPIRV-Headers.git"
		git-r3_fetch "https://github.com/KhronosGroup/SPIRV-Tools.git"
	fi
	git-r3_fetch ${EGIT_REPO_URI}

	if use tools ; then
		git-r3_checkout https://github.com/KhronosGroup/glslang.git \
			"${S}"/glslang
		git-r3_checkout https://github.com/KhronosGroup/SPIRV-Tools.git \
			"${S}"/spirv-tools
		rm "${S}"/spirv-tools/external/CMakeLists.txt
		git-r3_checkout https://github.com/KhronosGroup/SPIRV-Headers.git \
			"${S}"/spirv-tools/external
	fi
	git-r3_checkout ${EGIT_REPO_URI} "${S}"/sdk
}

src_compile() {
	if use tools ; then
		einfo "Building glslang"
		cd "${S}"/glslang
		cmake -H. -Bbuild
		cd "${S}"/glslang/build
		emake || die "cannot build glslang"
		make install || die "cannot install glslang"

		einfo "Building SPIRV-Tools"
		cd "${S}"/spirv-tools
		cmake -H. -Bbuild -DSPIRV_HEADER_INCLUDE_DIR="${S}/spirv-tools/external/include"
		cd "${S}"/spirv-tools/build
		emake || einfo "cannot build SPIRV-Tools"
	fi

	cd "${S}"/sdk
	cmake	\
		-DBUILD_WSI_XCB_SUPPORT=ON	\
		-DBUILD_WSI_XLIB_SUPPORT=ON	\
		-DBUILD_WSI_WAYLAND_SUPPORT=ON	\
		-DBUILD_WSI_MIR_SUPPORT=OFF	\
		-DBUILD_VKJSON=OFF		\
		-DBUILD_LOADER=ON		\
		-DBUILD_LAYERS=$(usex layers ON OFF)		\
		-DBUILD_DEMOS=$(usex tools ON OFF)		\
		-DBUILD_TESTS=OFF		\
		-DSPIRV_TOOLS_LIB="${S}"/spirv-tools/build/tools \
		-DGLSLANG_VALIDATOR="${S}"/glslang/build/install/bin/glslangValidator	\
		-H. -Bbuild
	cd "${S}"/sdk/build
	emake || einfo "cannot build Vulkan Loader"
}

src_install() {
	mkdir -p "${D}"/{etc,usr/share}/vulkan/icd.d
	mkdir -p "${D}"/usr/bin

	# prefix the tri and cube examples
	#mv "${S}"/sdk/build/demos/cube "${S}"/sdk/build/demos/vulkancube
	#mv "${S}"/sdk/build/demos/tri "${S}"/sdk/build/demos/vulkantri
	#dobin "${S}"/sdk/build/demos/vulkan{info,cube,tri}
	#dobin "${S}"/spirv-tools/build/tools/spirv-*

	if use tools ; then
		dobin "${S}"/sdk/build/demos/vulkaninfo
	fi

	# header files
	if use headers ; then
		mkdir -p "${D}"/usr/include
		cp -R "${S}"/sdk/include/vulkan "${D}"/usr/include
	fi

	# vulkan loader lib
	dolib.so "${S}"/sdk/build/loader/lib*.so*

	# vulkan validation layers
	if use layers ; then
		mkdir -p "${D}"/{etc,usr/share}/vulkan/{implicit_layer.d,explicit_layer.d}
		mkdir -p "${D}"/usr/$(get_libdir)/vulkan/layers
		mkdir -p "${D}"/etc/env.d

		exeinto /usr/$(get_libdir)/vulkan
		doexe "${S}"/sdk/build/layers/libVk*.so*

		# layer json files
		sed -i -e 's#./libVk#libVk#g' "${S}"/sdk/layers/linux/*.json
		insinto /usr/share/vulkan/explicit_layer.d
		doins "${S}"/sdk/layers/linux/*.json

		# point linker to newly created vulkan layer libs
		cat << EOF > "${D}"/etc/env.d/89vulkan
LDPATH="/usr/$(get_libdir)/vulkan;"
EOF
	fi

	dodoc "${S}"/sdk/LICENSE.txt

	find "${D}" -executable -type f -exec chrpath -d '{}' \;
}

pkg_postinst() {
	env-update
}
