import psycopg2
from datetime import date
conn = psycopg2.connect("dbname='cep' user='postgres'   password ='pass' host ='192.168.99.100' ")
cur = conn.cursor()
#with open("./croEG.txt",'r') as f:
#    lines = f.readlines()
fo = open("./croEG.txt","r",encoding='iso-8859-2',errors='ignore')
cp = 0
def formatedate(st):
    yy = int(st[0:4])
    mm = int(st[4:6])
    dd = int(st[6:8])
    return date(yy,mm,dd)
for ligne in fo:
       #print(cp)
       cp +=1
       crolop = ligne[0:3]
       ctcli = ligne[3:5]
       ccroanoc = ligne[5:6]
       poste_   = ligne[6:9]
       ccptind  = ligne[9:11]   #ligne[17:19]
       compte_  = ligne[11:17]
       scpttyp  = ligne[17:20]
       ccrodeno  = ligne[33:37]
       dcrodeno  = ligne[37:45]
       if dcrodeno =='00000000':
          dcrodeno =None
       else:
          dcrodeno = formatedate(dcrodeno)
       ncrodeno  = ligne[45:50]
       cbopnota  = ligne[50:53]
       ccronoti_1 = ligne[63:64]
       ccrodeni_1 = ligne [64:68]
       dcrodeni_1 =ligne [68:76]
       if dcrodeni_1 =='00000000':
          dcrodeni_1 =None
       else:
          dcrodeni_1 = formatedate(dcrodeni_1)
       ncrodeni_1 =ligne [76:81]
       dcroope   =ligne [382:390]
       if dcroope =='00000000':
          dcroope =None
       else:
          dcroope = formatedate(dcroope)
       dcroval   =ligne [390:398]
       if dcroval =='00000000':
          dcroval =None
       else:
          dcroval = formatedate(dcroval)
       dcroref   =ligne [510:518]
       if dcroref =='00000000':
          dcroref = None
       else:
          dcroref = formatedate(dcroref)
       ncrooper =    ligne [624:629]
       ncroref = ligne [518:523]
       numdep    = ligne[636:639]
       ncroarr   = ligne[639:640]
       cbopcont  = ligne[650:653]
       mcroope = ligne[272:287]
       lcroecrf = ligne[523:553]
       lcrobana = ligne[553:583]
       lcroban2 = ligne[583:613]
       lfacnomd = ligne[417:441]
       dfactran = ligne[441:447]
       nporcart = ligne[454:470]
       ncrocpte = ligne[403:414]
       lcrolib1 = ligne[441:471]
       sfac1001 = ligne[403:417]
       lcrodorm = ligne[417:441]
       ncropie1 = ligne[403:410]
       lheclibe = ligne[417:447]
       mfaccomp =  ligne[470:482]
       dfacrdab = ligne[447:451]
       hfacrdab = ligne[451:454]
       typlibcr =  ligne[398:400]
       dbrmrecp =  ligne[403:411]
       nbrmordr =  ligne[411:417]
       ccrosche = ligne[635:636]

       dcrodene = ligne[198:206]
       ncroposd = ligne[642:648]
       cboprgpt = ligne [648:650]
       ncroorgt = ligne[629:634]
       nhecrged = ligne[659:664]
       ccroeuro = ligne[664:665]
       print(compte_)
       cur.execute("INSERT INTO CRO_C23121A ( ID, ccrolop,ctcli , ccroanoc, poste_, ccptind, compte_,scpttyp, ccrodeno, dcrodeno, ncrodeno, cbopnota, ccrodeni_1, dcrodeni_1,ncrodeni_1, dcroope, dcroval , dcroref ,ncrooper, numdep,ncroref, ccronoti_1, cbopcont ,mcroope, lcroecrf,lcrobana,lcroban2,lfacnomd,dfactran,nporcart,ncrocpte,lcrolib1,sfac1001,lcrodorm,ncropie1,lheclibe,mfaccomp,dfacrdab, typlibcr,dbrmrecp,nbrmordr,ccrosche,hfacrdab, dcrodene, ncroposd,cboprgpt, ncroorgt,nhecrged, ccroeuro ,ncroarr ) \
       VALUES (%s,%s, %s,%s, %s,%s, %s,%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s,%s,  %s, %s, %s,%s, %s,  %s, %s, %s, %s, %s, %s, %s, %s,%s,%s, %s, %s, %s, %s,%s,  %s, %s, %s, %s, %s,%s,%s, %s, %s,%s, %s)", \
       (cp,crolop,ctcli , ccroanoc, poste_, ccptind, compte_,scpttyp, ccrodeno, dcrodeno, ncrodeno, cbopnota, ccrodeni_1, dcrodeni_1,ncrodeni_1, dcroope, dcroval , dcroref ,ncrooper,numdep,ncroref,ccronoti_1,cbopcont, mcroope, lcroecrf,lcrobana,lcroban2,lfacnomd,dfactran,nporcart,ncrocpte,lcrolib1,sfac1001,lcrodorm,ncropie1,lheclibe,mfaccomp,dfacrdab,typlibcr,dbrmrecp,nbrmordr ,ccrosche,hfacrdab, dcrodene, ncroposd,cboprgpt,ncroorgt,nhecrged, ccroeuro,ncroarr ))
conn.commit()
cur.close()
conn.close()
fo.close()
print(cp)
