

species = $(notdir $(wildcard output/*))
aliasTextToBed = ${HOME}/kent/src/hg/utils/automation/aliasTextToBed.pl

all: ${species:%=%_species}

%_species:
	${MAKE} makeChromAlias species=$*

# species=
outpre = output/${species}/${species}.chromAlias
chromSizes = ../241-mammalian-2020v2-hub/${species}/chrom.sizes

makeChromAlias: ${outpre}.bb


%.bb: %.txt
	${aliasTextToBed} -chromSizes=${chromSizes} -aliasText=$< -aliasBigBed=$@.tmp -aliasAs=${outpre}.as -aliasBed=${outpre}.bed
	mv -f $@.tmp $@
