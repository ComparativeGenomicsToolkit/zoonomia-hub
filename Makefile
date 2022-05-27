.SECONDARY:

url = http://courtyard.gi.ucsc.edu/data/cactus/241-mammalian-2020v2-hub/hub.txt

url_test = http://courtyard.gi.ucsc.edu/data/cactus/work/241-mammalian-2020v2-test-hub/hub.txt

genomes = $(shell cat ../241-mammalian-2020v2.genomes)

udcDir = /data/tmp/markd/udcCache
udcDir_test = /data/tmp/markd/udcCache_test

check: ${genomes:%=%_check}

%_check:
	hubCheck -genome=$* -udcDir=${udcDir} ${url}

check_test: ${genomes:%=%_check_test}

%_check_test:
	hubCheck -genome=$* -udcDir=${udcDir_test} ${url_test}
