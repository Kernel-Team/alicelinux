#!/bin/sh -e

. /etc/xpkg.conf
. /var/lib/pkg/functions

name=autoconf
version=2.69
url=https://ftp.gnu.org/gnu/$name/$name-$version.tar.xz

xfetch $url
xunpack $name-$version.tar.xz

cd $SRC/$name-$version

./configure \
	--prefix=/usr
make
make DESTDIR=$PKG install

xinstall

exit 0
