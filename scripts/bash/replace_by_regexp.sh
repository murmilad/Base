for i in `ls | grep ozf.map`; do dest=`echo $i|sed 's/^\([^_]*\).*/\1.map/'`; mv $i $dest; done;
