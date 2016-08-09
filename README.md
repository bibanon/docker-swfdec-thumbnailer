## How do I use it?

First, make sure to install docker on your server. Next, put all the swfs you want thumbnails for in an `swf/` directory. Then, run the following commands right above that same directory:

```
SWFDIR=`pwd`/swf         # change this to the folder which contains all your SWFs
git clone https://github.com/bibanon/docker-swfdec-thumbnailer/
cd docker-swfdec-thumbnailer
docker build -t swfdec-thumbnailer .
docker run -v $SWFDIR:/swf swfdec-gnome swfdec-thumbnailer 10seconds.swf 10seconds.swf.jpg
```

## Why SWFDec?

`swfdec-thumbnailer` is one of the few reliable thumbnailer programs. Unfortunately, the effort was abandoned in 2009 and software rot has kicked in. Arch Linux is the only system that maintains an `swfdec-gnome` package, so it's what we used here.

There is a replacement that uses Gnash, but as of this writing it still has issues processing some SWF types. (it might improve though)

We could also build something using Chrome, but even then you need to have a bloated graphical stack so I doubt it's all that much better. Chrome is aiming to abandon flash anyway.

The Bibliotheca Anonoma developed this docker container to generate SWF thumbnails for Danbooru/Moebooru.

https://danbooru.donmai.us/forum_topics/3383

## Why Arch Linux?

Arch Linux is the only system that still maintains an swfdec-gnome package (in the AUR) and keeps it working. We could have used Ubuntu 12.04 LTS, but it's too old.

## Why is it so bloated? (~1GB)

swfdec-gnome, true to it's name, requires an entire GTK2 graphical setup and multimedia processing libraries. And in order to build it, we need all the buildutils. 

So yeah, it's going to take up 1GB of space. Even if it were outside of a docker container it would still require all these dependencies anyway, so at least the mess is in a container that can be trashed when you've had it with it.
