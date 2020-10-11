import psycopg2 as Pg
con = Pg.connect( host='10.0.75.1', user='postgres', password='german', dbname='sps')
cur = con.cursor()
with open("matsps_ok.csv", 'r')  as f:
    lignes  = f.readlines()
cp = 1
for ligne in lignes:
    ligne = ligne[:-1]
    tab = ligne.split(';')
    chaine = f"INSERT into materiel (id , materiel, famille, criticite, quantite, hdv, obsolete, panne, ibm) \
    values ( %s, %s, %s, %s, %s, %s, %s, %s ,%s)"
    print(chaine) 
    slq = (cp, tab[0].strip(),tab[1].strip(), tab[2].strip(), tab[3], tab[4].strip(), tab[5].strip(),tab[6].strip(),tab[7].strip() )
    print(slq)
    cur.execute(chaine,slq )
    
    cp += 1

con.commit()
con.close()

     