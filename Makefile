.SECONDARY:

url=http://courtyard.gi.ucsc.edu/data/cactus/241-mammalian-2020v2-hub/

genomes = $(shell cat ../../241-mammalian-2020v2.genomes)

udcDir = /data/tmp/markd/udcCache

check: ${genomes:%=%_check}

%_check:
	hubCheck -genome=$* -udcDir=${udcDir} ${url}
