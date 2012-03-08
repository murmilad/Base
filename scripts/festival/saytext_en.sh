#!/bin/bash
# http://ru.festivalspeaker.wikia.com

echo "$1" | text2wave -o /home/alex/Scripts/festival/data/saytext_en.wav
aplay /home/alex/Scripts/festival/data/saytext_ru.wav > /dev/null 2>&1
