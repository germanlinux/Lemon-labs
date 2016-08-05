import psycopg2
conn = psycopg2.connect("dbname='gestab' user='postgres'   password ='pass' host ='192.168.99.100' ")
cur = conn.cursor()
fo = open("tableEG.txt","r",encoding='iso-8859-2',errors='ignore')
cp = 0
for ligne in fo:
    code = ligne[0:4]
    if code == 'CINT':
       cp +=1
       ccincass = ligne[4:5]
       ncincte = ligne[5:13]
       dtabval  =ligne[20:28]
       ccinmajb  = ligne[164:165]
       print(ligne)
       cur.execute("INSERT INTO CINT ( ccincass,ncincte,dtabval,ccinmajb ) \
       VALUES (%s,%s,%s,%s)",\
       (ccincass,ncincte,dtabval,ccinmajb))
conn.commit()
cur.close()
conn.close()
fo.close()
print(cp)
