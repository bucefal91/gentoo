# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_5 )

inherit distutils-r1

DESCRIPTION="An interactive, SSL-capable, man-in-the-middle HTTP proxy"
HOMEPAGE="https://mitmproxy.org/"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples test"

RDEPEND="
	<www-servers/tornado-4.5.0[${PYTHON_USEDEP}]
	=dev-python/blinker-1.4*[${PYTHON_USEDEP}]
	=dev-python/click-6*[${PYTHON_USEDEP}]
	dev-python/certifi[${PYTHON_USEDEP}]
	=dev-python/construct-2.8*[${PYTHON_USEDEP}]
	<dev-python/cryptography-1.9.0[${PYTHON_USEDEP}]
	<dev-python/cssutils-1.1.0[${PYTHON_USEDEP}]
	<dev-python/hyper-h2-3.0.0[${PYTHON_USEDEP}]
	<=dev-python/html2text-2016.9.19[${PYTHON_USEDEP}]
	<dev-python/hyperframe-5.0.0[${PYTHON_USEDEP}]
	<dev-python/jsbeautifier-1.7.0[${PYTHON_USEDEP}]
	dev-python/kaitaistruct[${PYTHON_USEDEP}]
	<dev-python/passlib-1.8[${PYTHON_USEDEP}]
	<dev-python/pyasn1-0.3[${PYTHON_USEDEP}]
	<dev-python/pyopenssl-17.0.0[${PYTHON_USEDEP}]
	<dev-python/pyparsing-2.3.0[${PYTHON_USEDEP}]
	<dev-python/pyperclip-1.6.0[${PYTHON_USEDEP}]
	<dev-python/requests-3.0.0[${PYTHON_USEDEP}]
	<dev-python/ruamel-yaml-0.14.0[${PYTHON_USEDEP}]
	<dev-python/urwid-1.4.0[${PYTHON_USEDEP}]
	<dev-python/watchdog-0.9.0[${PYTHON_USEDEP}]
	<dev-python/brotlipy-0.7[${PYTHON_USEDEP}]
	<dev-python/sortedcontainers-1.6.0[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/twisted[-crypt]
"

DEPEND="${RDEPEND}"

python_prepare_all() {
	distutils-r1_python_prepare_all

	# don't run example scripts tests
	rm test/mitmproxy/test_examples.py || die

}

python_test() {
	nosetests -v || die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	local DOCS=( CHANGELOG CONTRIBUTORS )
	use doc && local HTML_DOCS=( doc/. )
	use examples && local EXAMPLES=( examples/. )

	distutils-r1_python_install_all
}
