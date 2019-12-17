'''
CREATE TABLE public.essai
(
)

WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.essai
    OWNER to postgres;

'''

#!/usr/bin/env python
# coding: utf-8
'''
Exemple en java
      case "raw" : {
        type = "bytea";  
      } break;
      
      case "clob" : {
        type="text";
      }break;
      
      case "varchar2" : {
        type = "varchar";
        if( xfi.charlen != 0 ) {
          type += "(" + xfi.charlen + ")";
        }
      } break;
      
      case "char" : {
        type = "char";
        if( xfi.charlen != 0 ) {
          type += "(" + xfi.charlen + ")";
        }
      }break;
      
      case "number" : {
        type = "numeric";
        if( xfi.numlen != 0 && xfi.numlen != 31 ) {
          type += "(" + xfi.numlen + ")";
        }
      }break;
      
'''

import sys
import re

class Table:
  @classmethod
  def nom_si_existe(cls, objet):
    try:
      if objet.nom: 
        return objet.nom

    except: 
      return False



  def __init__(self, nom):
    self.nom = nom


file  = sys.argv[1]
with open(file, 'r') as f:
    lignes = f.readlines()
ens_table = set()
table_courante =""
for ligne in lignes:
    t_ligne = ligne.split(';')
    ens_table.add(t_ligne[0])
    if t_ligne[0] != Table.nom_si_existe(table_courante):
      # nouvelle table 
      # vider la precedante
      if table_courante:
        print(table_courante.send_sql())
      else:
        table_courante = Table(t_ligne[0])


#print(ens_table)
for item in ens_table:
    print('''             CREATE TABLE {} 
             (
             )
             WITH (
                 OIDS = FALSE
                 )
             TABLESPACE pg_default;

             ALTER TABLE {}
                 OWNER to postgres;
          '''.format(item, item))
