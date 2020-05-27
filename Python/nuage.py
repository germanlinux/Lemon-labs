#!/usr/bin/env python
# coding: utf-8
#volumetable.py
import sys
import operator
file  = sys.argv[1]
with open(file, 'r', encoding = 'cp1252') as f:
    lignes = f.readlines()
dic_m= {}
for ligne in lignes:
    t_ligne = ligne.split(';')
    for phrase in t_ligne:
            t_mot= phrase.split(' ')
            if len(t_mot) > 0:
                for mot in t_mot:
                    if mot in dic_m:
                        dic_m[mot] += 1
                    else:
                        dic_m[mot] = 1


sorted_d = sorted(dic_m.items(), key = operator.itemgetter(1), reverse = True)
#print(sorted_d[0:50])
tup2 = sorted_d[0:60]
for t in tup2:
    if len(t[0]) > 2 :
        for _ in range(0,t[1]):
          print(t[0])


