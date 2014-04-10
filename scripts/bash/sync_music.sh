#!/bin/bash

 for i in `ssh alex@media.homyaki.info ls -t /var/www/akosarev.info/htdocs/music` ; do if [ ! -d `ssh alex@media.homyaki.info ls /var/www/akosarev.info/htdocs/music/$i | awk '$0 !~ /\.zip/ {print $0}'` ]; then scp alex@media.homyaki.info:/var/www/akosarev.info/htdocs/music/$i/All.zip .; unzip ./All.zip; rm All.zip; else echo 0;  fi; done
