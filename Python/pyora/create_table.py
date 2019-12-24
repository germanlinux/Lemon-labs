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

class Colonne():
  def __init__(self, rang, nom, type_colonne, nature, longueur):
    self.rang = rang
    self.nom = nom
    self.type_colonne = type_colonne
    self.nature = nature
    self.longueur = longueur
    self.contrainte = False
  def add_contrainte(self):
    self.contrainte = True
  def send_sql(self):
    if self.longueur >= 250:
       self.type_colonne = 'TEXT'
    chaine =f"{self.nom}  "
    if self.type_colonne =="CHAR":
       chaine += "CHAR"
    elif self.type_colonne=='VARCHAR2':
       chaine += "VARCHAR"
    elif self.type_colonne=='NUMBER':
       chaine += 'NUMERIC'
    elif self.type_colonne=='DATE':
       chaine += 'TIMESTAMP' 
    elif self.type_colonne=='FLOAT':
       chaine += 'NUMERIC' 
    elif self.type_colonne=='CLOB':
       chaine += 'TEXT' 
    elif self.type_colonne=='TEXT':
       chaine += 'TEXT' 
       self.longueur =0 
    elif self.type_colonne=='NVARCHAR2':
       chaine += 'VARCHAR' 
    elif self.type_colonne=='TIMESTAMP(6)':
       chaine += 'TIMESTAMP'  
    elif self.type_colonne=='LONG':
       chaine += 'TEXT'
    elif self.type_colonne=='RAW':
       chaine += 'BYTEA'
       
    else:
       raise( NameError(f"erreur: {self.type_colonne}" )  )  
    if self.longueur > 0:
       chaine+=f"({self.longueur})"
    if self.contrainte:
       chaine += "   NOT NULL"
    else:
       chaine += "   NULL"        
    return chaine
              
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
    self.colonnes= []
    self.obj_colonnes= []
    self.pk = []
    self.nom_cle =''
  
  def send_contrainte(self):
    chaine ="CONSTRAINT  " + self.nom_cle + "  PRIMARY KEY ("
    sschaine = ""
    for item in self.pk:
      sschaine+=f"{item},"
    sschaine= sschaine[:-1]
    chaine += sschaine 
    chaine += ")"
    return chaine

  def add_ligne(self, liste_elt):
    rang = liste_elt[0]
    nom  = liste_elt[1]
    nature ='NP'
    contrainte ='N'
    type_colonne = liste_elt[2]
    if liste_elt[4] == 'P':
      nature = 'P'
      self.nom_cle = liste_elt[3]
      self.pk.append(nom)
    elif   liste_elt[4] == 'C':
      contrainte = 'Y'
    else:
      nature = 'NP'
    if liste_elt[5] :
      longueur = int(liste_elt[5])
    else:
      longueur = 0
    if nom in self.colonnes:
       ind = self.colonnes.index(nom)
       self.obj_colonnes[ind].add_contrainte()

    else:
       ligne = Colonne(rang, nom, type_colonne, nature, longueur)
       if contrainte == 'Y':
        ligne.add_contrainte() 
       self.colonnes.append(nom)
       self.obj_colonnes.append(ligne)

  def send_sql(self):
      chaine ='''             CREATE TABLE {}
                 ( '''.format(self.nom)
      for item in self.obj_colonnes:
         chaine += '''{} , 
                   '''.format(item.send_sql())
      if self.nom_cle:
         chaine += self.send_contrainte()
      else: 
         chaine = chaine[:-22]
      
      chaine += '''
             )
             WITH (
                 OIDS = FALSE
                 )
             TABLESPACE pg_default;

             ALTER TABLE {}
                 OWNER to postgres;
          '''.format(self.nom) 
      #print(chaine)
      return chaine

''' debut programme'''
      
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
      table_courante = Table(t_ligne[0])

    table_courante.add_ligne(t_ligne[1:])
if table_courante:
    print(table_courante.send_sql())

