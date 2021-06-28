# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="NVIDIA Ray Tracing Engine"
HOMEPAGE="https://developer.nvidia.com/optix"
SRC_URI="NVIDIA-OptiX-SDK-${PV}-linux64.sh"
S="${WORKDIR}"

LICENSE="NVIDIA-SDK"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist fetch"

DOCS=( doc/OptiX_{API_Reference,Programming_Guide}_${PV}.pdf )

pkg_nofetch() {
	einfo "Please download ${SRC_URI} from:"
	einfo "  ${HOMEPAGE}"
	einfo "and move it to your DISTDIR directory."
}

src_unpack() {
	tail -n +223 "${DISTDIR}"/${A} | tar -zx
	assert "unpacking ${A} failed"
}

src_install() {
	insinto /usr/include/${PN}
	doins -r include/.

	einstalldocs
}
