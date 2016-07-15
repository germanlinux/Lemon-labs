import psycopg2
conn = psycopg2.connect("dbname='gestab' user='postgres'   password ='pass' host ='192.168.99.100' ")
cur = conn.cursor()
fo = open("tableEG.txt","r",encoding='iso-8859-2',errors='ignore')
cp = 0
for ligne in fo:
    code = ligne[0:4]
    if code == 'PARR':
       cp +=1
       cbopcont = ligne[4:7]
       dtabval  =ligne[20:28]
       cparcgf  = ligne[39:40]
       nparcgfp =ligne[40:48]
       cparlifp =ligne[48:49]
       nparlifp =ligne[49:57]
       cparcpar =ligne[57:58]
       nparcpar =ligne[58:66]
       nparspe1 =ligne[66:78]
       nparspe2 =ligne[78:84]
       cparipfp =ligne[84:85]
       nparipfp   =ligne[85:93]
       cparipdt   =ligne[93:94]
       nparipdt   =ligne[94:102]
       cparipcd   =ligne[102:103]
       nparipcd   =ligne[103:111]
       cparadfp   = ligne[111:112]
       nparadfp  =ligne[112:120]
       cparapfp  =ligne[120:121]
       nparapfp  =ligne[121:129]
       cparadt   =ligne[129:130]
       nparadt   =ligne[130:138]
       cparacdc   =ligne[138:139]
       nparacdc   =ligne[139:147]
       print(ligne)
       cur.execute("INSERT INTO PARR ( cbopcont, dtabval,cparcgf ,nparcgfp,cparlifp,nparlifp,cparcpar,nparcpar,nparspe1,nparspe2,cparipfp,\
       nparipfp,cparipdt,nparipdt,cparipcd,nparipcd,cparadfp,nparadfp,cparapfp,nparapfp,cparadt ,nparadt ,cparacdc,nparacdc ) \
       VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",(cbopcont, dtabval,cparcgf ,nparcgfp,cparlifp,nparlifp,cparcpar,nparcpar,nparspe1,nparspe2,cparipfp, \
       nparipfp,cparipdt,nparipdt,cparipcd,nparipcd,cparadfp,nparadfp,cparapfp,nparapfp,cparadt ,nparadt ,cparacdc,nparacdc))
conn.commit()
cur.close()
conn.close()
fo.close()
print(cp)
