#!/bin/sh -e

. /etc/xpkg.conf
. /var/lib/pkg/functions

name=musl-obstack
version=1.1
url=https://github.com/pullmoll/musl-obstack/archive/v$version/$name-$version.tar.gz

xfetch $url
xunpack $name-$version.tar.gz

cd $SRC/$name-$version

./bootstrap.sh
./configure --prefix=/usr
make
make DESTDIR=$PKG install

xinstall

exit 0
