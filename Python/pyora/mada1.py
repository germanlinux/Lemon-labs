#!/usr/bin/env python
# coding: utf-8

import sys
import re
file  = sys.argv[1]
with open(file, 'r') as f:
    lignes = f.readlines()
re_colonne= r'"(.+)" (.+)  '
for ligne in lignes:
    if len(ligne) > 30:
        if ligne[31] == '"':
            table = ligne[:31].strip()
            r_colonne    = re.search(re_colonne,ligne[31:-1])
            if r_colonne:
                colonne = r_colonne[1].strip()
                nature = r_colonne[2]
            else:
                print('ERREUR')    
            print(f"{table};{colonne};{nature}")    
