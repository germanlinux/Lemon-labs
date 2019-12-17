#!utf-8
#!/usr/bin/python3
import sys
import string
 
def main(nom_fichier):
    with open(nom_fichier,"r",encoding="Latin-1") as file:
        texte = file.readlines()
    for ligne in texte:
        if len(ligne) > 100 and ligne[40] in string.digits :
                table = ligne[:30].strip()
                numero = ligne[31:41].strip()
                colonne = ligne[42:72].strip()
                data = ligne[73:179].strip()
                contrainte = ligne[180:210].strip()
                c = ligne[211]
                longueur = ligne[212:233].strip()
                precision = ligne[234:].strip()
                print(f"{table};{numero};{colonne};{data};{contrainte};{c};{longueur};{precision}")     

fichier = sys.argv[1]
main(fichier)
