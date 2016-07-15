import psycopg2
conn = psycopg2.connect("dbname='gestab' user='postgres'   password ='pass' host ='192.168.99.100' ")
cur = conn.cursor()
fo = open("tableEG.txt","r",encoding='iso-8859-2',errors='ignore')
cp = 0
for ligne in fo:
    code = ligne[0:4]
    if code == 'YCTE':
       cp +=1
       ccptind = ligne[4:6]
       scpttyp = ligne[6:9]
       dtabval  =ligne[20:28]
       syctcass  = ligne[157:166]
       print(ligne)
       cur.execute("INSERT INTO YCTE ( ccptind,scpttyp,dtabval,syctcass ) \
       VALUES (%s,%s,%s,%s)",\
       (ccptind,scpttyp,dtabval,syctcass))
conn.commit()
cur.close()
conn.close()
fo.close()
print(cp)
