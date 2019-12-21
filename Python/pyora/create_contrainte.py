
#!/usr/bin/env python
# coding: utf-8

import sys
import re


re_doublecote = r'/ "|" '

file  = sys.argv[1]
with open(file, 'r') as f:
    lignes = f.readlines()
for ligne in lignes:
    if 'FOREIGN KEY' in ligne:
        ligne= ligne.replace('TABLE "','TABLE ')
        ligne= ligne.replace('CONSTRAINT "','CONSTRAINT ')
        ligne= ligne.replace('REFERENCES "','REFERENCES ')
        ligne= ligne.replace('" ',' ')
        print(ligne)

