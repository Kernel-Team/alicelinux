#!/bin/sh

set -e

. /etc/pkg.conf
. /var/lib/pkg/functions

name=automake
version=1.16.3
url=https://ftp.gnu.org/gnu/$name/$name-$version.tar.xz

xfetch $url
xunpack $name-$version.tar.xz

cd $SRC/$name-$version

./configure --prefix=/usr
make
make DESTDIR=$PKG install

xinstall $version

exit 0
