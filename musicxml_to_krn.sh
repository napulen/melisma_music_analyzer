#!/bin/bash
for i in phd_testset_chordified/*.xml
do
	echo Converting $i
	/home/napulen/humlib/bin/musicxml2hum $i > phd_testset_krn/$(basename $i .mxl).krn
done
