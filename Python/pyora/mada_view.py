#!/usr/bin/env python
# coding: utf-8

import sys
import re
file  = sys.argv[1]
with open(file, 'r') as f:
    lignes = f.readlines()
debut = 0
listp = []
#chainesql =  f"SELECT text FROM User_Source WHERE name = '{item}' ORDER BY line"
#r_espace = r'/(^.+)$/'
for ligne in lignes:
    if ligne[0:3] == '---':
       debut = 1
       continue
    if debut == 1 and len(ligne) < 3:
        debut = 0   
    if debut == 1:
        listp.append(ligne[:-1])

for item in listp:
    chainesql =  f"SELECT text FROM User_Source WHERE name = '{item}' ;"
    print(chainesql)  
