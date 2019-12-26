#!/usr/bin/env python
# coding: utf-8
#volumetable.py
import cx_Oracle
import sys
file  = sys.argv[1]
con_o = cx_Oracle.connect('safi/safi@localhost/safi')
curo = con_o.cursor()
sql_r = "select count(*) from "
with open(file, 'r') as f:
    lignes = f.readlines()
for ligne in lignes:
    ligne = ligne[:-1]
  #  print(ligne)
    curo.execute(sql_r + ligne)
    row = curo.fetchone()
    print(f"{ligne};{row[0]}")
con_o.close()    
