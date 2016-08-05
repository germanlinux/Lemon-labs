import psycopg2
conn = psycopg2.connect("dbname='gestab' user='postgres'   password ='pass' host ='192.168.99.100' ")
cur = conn.cursor()
fo = open("tableEG.txt","r",encoding='iso-8859-2',errors='ignore')
cp = 0
for ligne in fo:
    code = ligne[0:4]
    if code == 'BOPE':
       cp +=1
       ccrolop = ligne[4:7]
       ccptind = ligne[7:9]
       scpttyp = ligne[9:12]
       dtabval  =ligne[20:28]
       cbopcjc  = ligne[91:92]
       cbopcont = ligne[84:87]
       print(ligne)
       cur.execute("INSERT INTO bope ( ccrolop, ccptind,scpttyp,dtabval,cbopcjc, cbopcont ) \
       VALUES (%s,%s,%s,%s, %s, %s)",\
       (ccrolop,ccptind,scpttyp,dtabval,cbopcjc, cbopcont))
conn.commit()
cur.close()
conn.close()
fo.close()
print(cp)
