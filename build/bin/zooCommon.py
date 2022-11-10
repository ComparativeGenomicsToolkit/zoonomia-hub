import re
from pycbio.tsv import TsvReader

fixedMappings = {
    "Alouatta_palliata": "Alouatta_palliata_mexicana",
    "Ovis_canadensis": "Ovis_canadensis_cremnobates",
    "Perognathus_longimembris": "Perognathus_longimembris_pacificus",
    "Platanista_gangetica": "Platanista_gangetica_minor",
    "Saiga_tatarica": "Saiga_tatarica_tatarica",
    "Tupaia_chinensis": "Tupaia_belangeri_chinensis",
}

class GenomeMissingError(Exception):
    pass

def ucscEquivToAcc(row):
    m = re.search("^([A-Z]{3}_[0-9.]+)_.*$", row.Ucsc_Equiv)
    if m is not None:
        return m.group(1)
    else:
        return row.Ucsc_Equiv

def loadZooEquiv():
    return {r.Hub_Species: r
            for r in TsvReader("zoo241.equivalence.tsv",
                               columns=("Hub_Species", "Ucsc_Equiv"))}

def getZooGenArkRec(zooToGenArk, genome):
    if genome in zooToGenArk:
        return zooToGenArk[genome]
    if genome in fixedMappings:
        return zooToGenArk[fixedMappings[genome]]
    raise GenomeMissingError("missing mapping for: " + genome)

def getZooGenArkAcc(zooToGenArk, genome):
    # /cluster/home/hiram/kent/src/hg/makeDb/doc/zoonomiaAsmHub/zoo241.equivalence.tsv
    return ucscEquivToAcc(getZooGenArkRec(zooToGenArk, genome))
