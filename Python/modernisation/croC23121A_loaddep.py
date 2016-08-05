import psycopg2
from datetime import date
conn = psycopg2.connect("dbname='cep' user='postgres'   password ='pass' host ='192.168.99.100' ")
cur = conn.cursor()
ins = conn.cursor()
#with open("./croEG.txt",'r') as f:
def append_base(cp, record):
     id = cp
     ccrolop = record[1]
     ctcli =    record[2]
     ccroanoc = record[3]
     poste_   = record[4]
     ccptind   = record[5]
     compte_  = record[6]
     scpttyp  = record[7]
     ccrodeno = record[8]
     dcrodeno = record[9]
     ncrodeno = record[10]
     cbopnota = record[11]
     ccrodeni_1 = record[12]
     dcrodeni_1 = record[13]
     ncrodeni_1 = record[14]
     dcroope  = record[15]
     dcroval  = record[16]
     dcroref  = record[17]
     ncrooper  = record[18]
     numdep    = record[19]
     ncroref =  record[20]
     ccronoti_1 = record[21]
     cbopcont = record[22]
     mcroope  = record[23]
     lcroecrf = record [24]
     lcroecrf_Sauve = record [24]
     lcrobana = record[25]
     lcroban2 = record[26]
     lfacnomd = record[27]
     dfactran = record[28]
     nporcart = record[29]
     ncrocpte = record[30]
     lcrolib1 = record[31]
     sfac1001 = record[32]
     lcrodorm = record[33]
     ncropie1 = record[34]
     lheclibe = record[35]
     mfaccomp = record[36]
     dfacrdab = record[37]
     typlibcr  = record[38]
     dbrmrecp  = record[39]
     nbrmordr  = record[40]
     ccrosche  =record[41]
     hfacrdab = record[42]
     dcrodene = record[43]
     ncroposd = record[44]
     cboprgpt = record[45]
     ins.execute("INSERT INTO CRO_C23121Adep ( ID, ccrolop,ctcli , ccroanoc, poste_, ccptind, compte_,scpttyp, ccrodeno, dcrodeno, ncrodeno, cbopnota, ccrodeni_1, dcrodeni_1,ncrodeni_1, dcroope, dcroval , dcroref ,ncrooper, numdep,ncroref, ccronoti_1, cbopcont ,mcroope, lcroecrf,lcrobana,lcroban2,lfacnomd,dfactran,nporcart,ncrocpte,lcrolib1,sfac1001,lcrodorm,ncropie1,lheclibe,mfaccomp,dfacrdab, typlibcr,dbrmrecp,nbrmordr,ccrosche,hfacrdab, dcrodene,ncroposd,cboprgpt ) \
       VALUES (%s,%s,%s, %s,%s, %s,%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s,%s,  %s, %s, %s,%s, %s,  %s, %s, %s, %s, %s, %s, %s, %s,%s,%s, %s, %s, %s, %s,%s,  %s, %s, %s, %s, %s,%s, %s,%s)", \
       (cp,ccrolop,ctcli , ccroanoc, poste_, ccptind, compte_,scpttyp, ccrodeno, dcrodeno, ncrodeno, cbopnota, ccrodeni_1, dcrodeni_1,ncrodeni_1, dcroope, dcroval , dcroref ,ncrooper,numdep,ncroref,ccronoti_1,cbopcont, mcroope, lcroecrf,lcrobana,lcroban2,lfacnomd,dfactran,nporcart,ncrocpte,lcrolib1,sfac1001,lcrodorm,ncropie1,lheclibe,mfaccomp,dfacrdab,typlibcr,dbrmrecp,nbrmordr ,ccrosche,hfacrdab, dcrodene,ncroposd,cboprgpt ))


cp =1
cur.execute("SELECT * FROM CRO_C23121A where numdep <'020' ORDER BY  numdep ,dcroope, ncrooper, ccrolop;")
for record in cur:
     append_base(cp, record)
     cp +=1

conn.commit()
cur.execute("SELECT * FROM CRO_C23121A where numdep = '02A' ORDER BY  numdep ,dcroope, ncrooper, ccrolop;")
for record in cur:
     append_base(cp, record)
     cp +=1

conn.commit()
cur.execute("SELECT * FROM CRO_C23121A where numdep = '02B' ORDER BY  numdep ,dcroope, ncrooper, ccrolop;")
for record in cur:
     append_base(cp, record)
     cp +=1

conn.commit()
cur.execute("SELECT * FROM CRO_C23121A where numdep > '020' and numdep != '02A' and numdep  != '02B'  ORDER BY  numdep ,dcroope, ncrooper, ccrolop;")
for record in cur:
     append_base(cp, record)
     cp +=1

conn.commit()
cur.close()
ins.close()

conn.close()
print(cp)
