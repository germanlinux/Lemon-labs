
#!/usr/bin/env python
# coding: utf-8

import sys
import re


re_doublecote = r'/ "|" '

file  = sys.argv[1]
with open(file, 'r') as f:
    lignes = f.readlines()
for ligne in lignes:
    if 'CREATE INDEX' in ligne:
        #ligne= ligne.replace('INDEX "','INDEX ')
        #ligne= ligne.replace('" ON "',' ON ')
        #ligne= ligne.replace('" (',' (')
        ligne= ligne.replace('"','')
        ligne= ligne[:-1]
        print(ligne)

