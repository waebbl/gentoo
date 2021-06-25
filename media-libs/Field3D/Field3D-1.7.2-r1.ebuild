# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="A library for storing voxel data"
HOMEPAGE="http://opensource.imageworks.com/?p=field3d"
SRC_URI="https://github.com/imageworks/Field3D/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="mpi"

BDEPEND="virtual/pkgconfig"
RDEPEND="
	>=dev-libs/boost-1.62:=
	>=media-libs/ilmbase-2.5.0:0=
	sci-libs/hdf5:=
	mpi? ( virtual/mpi )
"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/${P}-0001-use-correct-include-dir.patch"
	"${FILESDIR}/${P}-0002-fixes-to-find-IlmBase.patch"
)

CMAKE_REMOVE_MODULES_LIST="FindILMBase"

src_configure() {
	local mycmakeargs=(
		-DINSTALL_DOCS=OFF # Docs are not finished yet.
		-DCMAKE_DISABLE_FIND_PACKAGE_Doxygen=ON
		$(cmake_use_find_package mpi MPI)
	)
	cmake_src_configure
}
