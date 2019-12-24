
#!/usr/bin/env python
# coding: utf-8

import sys
import re

subre_safi = r'SAFIRA_PRODUCTION\.'
subre_type = r'([^,)])( TYPE)([^_])'
subre_posi = r'([^,])( POSITION)([^_])'
subre_name = r'([^,])( NAME)([^_])'
subre_owner = r'([^,])( OWNER)([^_])'

class Vue():
    def __init__(self):
        self.lignes = []

    def add_ligne(self, ligne):
        ligne = ligne.replace('"','')
        ligne= ligne.replace('REPLACE FORCE', 'REPLACE')
       # ligne= ligne.replace('SAFIRA_PRODUCTION.','')
        #ligne = ligne.replace(' NAME',' AS NAME')
        ligne =  re.sub(subre_name,r'\1 AS \2\3',ligne,flags= re.IGNORECASE)
        ligne =  re.sub(subre_posi,r'\1 AS \2\3',ligne,flags= re.IGNORECASE)
        ligne =  re.sub(subre_type,r'\1 AS \2\3',ligne,flags= re.IGNORECASE)
        ligne =  re.sub(subre_owner,r'\1 AS \2\3',ligne,flags= re.IGNORECASE)
#        ligne = ligne.replace(' TYPE',' AS TYPE')
#       ligne = ligne.replace(' name',' AS name')
#        ligne = ligne.replace(' type',' AS type')
#        ligne = ligne.replace(' owner',' AS owner')
#        ligne = ligne.replace(' OWNER',' AS OWNER')
#        ligne = ligne.replace(' POSITION',' AS POSITION')
#        ligne = ligne.replace(' position',' AS position')

        ligne = ligne.replace(' MINUS',' EXCEPT')
        
        ligne= re.sub(subre_safi,'',ligne,flags= re.IGNORECASE)
        
        self.lignes.append(ligne)

    def send_sql(self):
        for ligne in self.lignes:
            print(ligne)
        print('------------')    
 
file  = sys.argv[1]
with open(file, 'r') as f:
    lignes = f.readlines()
flagdebut = False    
for ligne in lignes:
    ligne= ligne[:-1]
    if '------------' in ligne:
        flagdebut = True
        mavue = Vue()
        continue
    if not ligne :
        flagdebut = False
        mavue.send_sql()
        continue
    if flagdebut :
        mavue.add_ligne(ligne)

'''
        ligne= ligne.replace('"','')
        ligne= ligne[:-1]
        print(ligne)
'''
