#!/usr/bin/env python
# coding: utf-8
from os import walk
import sys
monRepertoire = sys.argv[1]

listeFichiers = []
for (repertoire, sousRepertoires, fichiers) in walk(monRepertoire):
    fichiers2 = [x + ';' + repertoire  for x in fichiers]
    listeFichiers.extend(fichiers2)
for item in listeFichiers:
	item1 = item.encode('utf-8')
	ttim = item1.decode('ascii',errors = 'ignore')
	print(ttim)