#!/bin/bash
#musicinfo.sh
echo "Artist: `mpc current -f %artist%`"
echo "Album: `mpc current -f %album%`"
echo "Title: `mpc current -f %title%`"
echo "File: `mpc current -f %file% | grep -oP '[^/]+$'`"
