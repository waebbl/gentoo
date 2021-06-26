# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="AMPAS' Color Transformation Language"
HOMEPAGE="https://github.com/ampas/CTL"
SRC_URI="https://github.com/ampas/CTL/archive/${P}.tar.gz"

LICENSE="AMPAS"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"

RDEPEND="media-libs/ilmbase:0=
	media-libs/openexr:0=
	media-libs/tiff:=
	!media-libs/openexr_ctl"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

S="${WORKDIR}/CTL-ctl-${PV}"

#	"${FILESDIR}/${P}-Use-GNUInstallDirs-and-fix-PkgConfig-files-1.patch"
PATCHES=(
	"${FILESDIR}/${P}-use-GNUInstallDirs-and-slotted-openexr.patch"
	"${FILESDIR}/${P}-openexr-2.3.patch"
)

mycmakeargs=( -DCMAKE_INSTALL_DOCDIR="share/doc/${PF}" )
