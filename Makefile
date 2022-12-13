.SECONDARY:

url = http://courtyard.gi.ucsc.edu/data/cactus/241-mammalian-2020v2-hub/hub.txt
udcDir = /data/tmp/markd/udcCache

url_test = http://courtyard.gi.ucsc.edu/data/cactus/work/241-mammalian-2020v2-test-hub/hub.txt
udcDir_test = /data/tmp/markd/udcCache_test

url_hgwdev = https://hgwdev.gi.ucsc.edu/~markd/zoonomia/241-mammalian-2020v2-hub/hub.txt
udcDir_hgwdev = /data/tmp/markd/udcCache_hgwdev

genomes = $(shell cat 241-mammalian-2020v2.genomes)

# merge trackDbs

all: ${genomes:%=%/trackDb.txt}

%/trackDb.txt: %/main.trackDb.txt
	build/bin/mergeTrackDb $< $@.tmp
	mv -f $@.tmp $@

check: ${genomes:%=%_check}

%_check: %/trackDb.txt
	hubCheck -genome=$* -udcDir=${udcDir} ${url}

check_test: ${genomes:%=%_check_test}

%_check_test: %/trackDb.txt
	hubCheck -genome=$* -udcDir=${udcDir_test} ${url_test}

check_hgwdev: ${genomes:%=%_check_hgwdev}

%_check_hgwdev: %/trackDb.txt
	hubCheck -genome=$* -udcDir=${udcDir_hgwdev} ${url_hgwdev}
