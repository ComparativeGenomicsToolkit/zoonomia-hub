.SECONDARY:

url_courtyard = http://courtyard.gi.ucsc.edu/data/cactus/241-mammalian-2020v2-hub/hub.txt
udcDir_courtyard = /data/tmp/markd/udcCache

url_test = http://courtyard.gi.ucsc.edu/data/cactus/work/241-mammalian-2020v2-test-hub/hub.txt
udcDir_test = /data/tmp/markd/udcCache_test

url_hgwdev = https://hgwdev.gi.ucsc.edu/~markd/zoonomia/241-mammalian-2020v2-hub/hub.txt
udcDir_hgwdev = /data/tmp/markd/udcCache_hgwdev

genomes = $(shell cat 241-mammalian-2020v2.genomes)

# merge trackDbs

all: ${genomes:%=%_trackDb}

%_trackDb:
	${MAKE} doTrackDb genome=$*

# recursive target
doTrackDb: ${genome}/trackDb.txt

${genome}/trackDb.txt: ${genome}/main.trackDb.txt $(wildcard ${genome}/*.trackDb.txt trackDb/*.trackDb.txt) $(wildcard trackDb/*/*.trackDb.txt)
	build/bin/mergeTrackDb $< $@.tmp
	mv -f $@.tmp $@

clean:
	rm -f */trackDb.txt

check: ${genomes:%=%_check}

%_check:
	${MAKE} doHubCheck genome=$* udcDir=${udcDir_courtyard} url=${url_courtyard}

check_test: ${genomes:%=%_check_test}

%_check_test:
	${MAKE} doHubCheck genome=$* udcDir=${udcDir_test} url=${url_test}

check_hgwdev: ${genomes:%=%_check_hgwdev}

%_check_hgwdev:
	${MAKE} doHubCheck genome=$* udcDir=${udcDir_hgwdev} url=${url_hgwdev}

# recursive target
doHubCheck: ${genome}/trackDb.txt
	hubCheck -genome=${genome} -udcDir=${udcDir} ${url}
