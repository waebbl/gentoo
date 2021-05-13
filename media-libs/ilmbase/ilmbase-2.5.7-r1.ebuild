# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_ECLASS=cmake
inherit cmake-multilib flag-o-matic

DESCRIPTION="OpenEXR ILM Base libraries"
HOMEPAGE="https://www.openexr.com/"
SRC_URI="https://github.com/AcademySoftwareFoundation/openexr/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/openexr-${PV}/IlmBase"

LICENSE="BSD"
SLOT="0/25" # based on SONAME
KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~x64-macos ~x86-solaris"
IUSE="large-stack static-libs test"
RESTRICT="!test? ( test )"

BDEPEND="virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}"/${PN}-2.5.4-0001-disable-failing-test-on-x86_32.patch
	"${FILESDIR}"/${P}-0001-changes-needed-for-proper-slotting.patch
)

multilib_src_configure() {
	local MY_PV=$(ver_cut 1)
	local mycmakeargs=(
		-DBUILD_TESTING=$(usex test)
		-DILMBASE_BUILD_BOTH_STATIC_SHARED=$(usex static-libs)
		-DILMBASE_ENABLE_LARGE_STACK=$(usex large-stack)
		-DILMBASE_INSTALL_PKG_CONFIG=ON
		# needed for proper slotting
		-DILMBASE_OUTPUT_SUBDIR="OpenEXR-${MY_PV}"
	)

	cmake_src_configure
}
