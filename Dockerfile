# swfdec-thumbnailer
# VERSION 0.0.1
# 
# Installs an arch linux docker image with swfdec-thumbnailer set up.
# based on rafaelsoares/archlinux latest docker image
# https://github.com/rafaelsoares/archlinux

FROM rafaelsoares/archlinux:latest
MAINTAINER Antonizoon <antonizoon@bibanon.org>

RUN pacman -Syyu --noprogressbar --noconfirm
RUN pacman --noprogressbar --noconfirm -S base-devel # install package dependencies and base-devel
RUN pacman --noprogressbar --noconfirm -S curl gtk2 libsoup alsa-lib liboil gstreamer0.10-base-plugins gtk-doc 
RUN pacman --noprogressbar --noconfirm -S libmad gstreamer0.10-ffmpeg gconf intltool

# create the working directory
WORKDIR /tmp/scratch
RUN chown nobody:nobody /tmp/scratch

# build the package
USER nobody
RUN curl https://aur.archlinux.org/cgit/aur.git/snapshot/swfdec.tar.gz | tar zx
WORKDIR /tmp/scratch/swfdec
RUN makepkg --noconfirm

# install the package
USER root
RUN pacman -U *.pkg.tar.xz --noprogressbar --noconfirm

WORKDIR /tmp/scratch
USER nobody
RUN curl https://aur.archlinux.org/cgit/aur.git/snapshot/swfdec-gnome.tar.gz | tar zx
WORKDIR /tmp/scratch/swfdec-gnome
RUN makepkg --noconfirm

# install the package
USER root
RUN pacman -U *.pkg.tar.xz --noprogressbar --noconfirm

# clean up, uninstall buildutils to save 160MB
USER root
RUN rm -rf /tmp/scratch
RUN pacman --noprogressbar --noconfirm -Rs make sudo autoconf automake gcc bison binutils libtool 

# make it possible to access a folder from the host just for swfs 
WORKDIR /swf
VOLUME ["/swf"]
