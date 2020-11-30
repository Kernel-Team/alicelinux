#!/bin/sh

set -e

. /etc/pkg.conf
. /var/lib/pkg/functions

name=ncurses
version=6.2
url=https://ftp.gnu.org/gnu//$name/$name-$version.tar.gz

xfetch $url
xunpack $name-$version.tar.gz

cd $SRC/$name-$version

sed -i '/LIBTOOL_INSTALL/d' c++/Makefile.in

./configure --prefix=/usr \
			--mandir=/usr/share/man \
			--with-pkg-config-libdir=/usr/lib/pkgconfig \
			--with-shared \
			--without-debug \
			--without-normal \
			--enable-pc-files \
			--enable-widec
make
make DESTDIR=$PKG install

mkdir -p $PKG/lib
mv -v $PKG/usr/lib/libncursesw.so.6* $PKG/lib
ln -sfv ../../lib/$(readlink $PKG/usr/lib/libncursesw.so) $PKG/usr/lib/libncursesw.so

for lib in ncurses form panel menu ; do
	rm -vf                    $PKG/usr/lib/lib${lib}.so
	echo "INPUT(-l${lib}w)" > $PKG/usr/lib/lib${lib}.so
	ln -sfv ${lib}w.pc        $PKG/usr/lib/pkgconfig/${lib}.pc
done

rm -vf                     $PKG/usr/lib/libcursesw.so
echo "INPUT(-lncursesw)" > $PKG/usr/lib/libcursesw.so
ln -sfv libncurses.so      $PKG/usr/lib/libcurses.so

# conflict with busybox
rm $PKG/usr/bin/clear

xinstall

exit 0
