#!/bin/bash
SWFDIR=`pwd`/swf

# run the swfdec-thumbnailer on a single .swf file in a folder
#docker run -v $SWFDIR:/swf swfdec-thumbnailer swfdec-thumbnailer 10seconds.swf 10seconds.swf.jpg

# run the swfdec-thumbnailer on all .swf files in a folder
docker run -v $SWFDIR:/swf swfdec-thumbnailer find . -maxdepth 1 -type f -exec swfdec-thumbnailer {} {}.jpg \;

# there might be errors, but ignore them for the most part: especially audio decoding errors, because who cares, we just make thumbnails.
