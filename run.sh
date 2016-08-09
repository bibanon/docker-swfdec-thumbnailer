#!/bin/bash
# run the swfdec-thumbnailer on a single .swf file in a folder
docker run -v `pwd`/swf:/swf swfdec-gnome swfdec-thumbnailer 10seconds.swf 10seconds.swf.jpg

# run the swfdec-thumbnailer on all .swf files in a folder
