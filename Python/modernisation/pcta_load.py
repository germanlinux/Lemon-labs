import psycopg2
conn = psycopg2.connect("dbname='gestab' user='postgres'   password ='pass' host ='192.168.99.100' ")
cur = conn.cursor()
fo = open("tableEG.txt","r",encoding='iso-8859-2',errors='ignore')
cp = 0
for ligne in fo:
	code = ligne[0:4]
	if code == 'PCTA' :
	   cp +=1
	   print(ligne)
	   ope  = ligne[4:7]
	   typeclt = ligne[7:9]
	   ano = ligne[9:10]
	   nuti = ligne[10:14]
	   numero = ligne[14:16]
	   filler1 = ligne[16:20]
	   date = ligne[20:28]
	   sens =  ligne[39:40]
	   chunk =  ligne[40:41]
	   gptype = chunk.strip()
	   chunk =  ligne[41:42]
	   dval = chunk.strip()
	   chunk= ligne[42:50]
	   mafi = chunk.strip()
	   chunk = ligne[50:58]
	   taru =  chunk.strip()
	   chunk = ligne[58:66]
	   resu =  chunk.strip()
	   chunk = ligne[66:67]
	   ecrm =   chunk.strip()
	   chunk = ligne[67:69]
	   jouv =   chunk.strip()
	   chunk = ligne[69:72]
	   sqlclop = chunk.strip()
	   chunk =  ligne[72:74]
	   sqltyp  = chunk.strip()
	   chunk = ligne[74:75]
	   sqlanoc = chunk.strip()
	   chunk = ligne[75:79]
	   sqlnuti= chunk.strip()
	   chunk = ligne[79:81]
	   sqllgns = chunk.strip()
	   chunk = ligne[81:82]
	   exoc = chunk.strip()
	   chunk = ligne[82:86]
	   algo = chunk.strip()
	   chunk = ligne[86:88]
	   refn=  chunk.strip()
	   #filler2 = strip( ligne[78:9])
	   chunk = ligne[88:91]
	   operebond =  chunk.strip()
	   chunk = ligne[91:93]
	   typerebond = chunk.strip()
	   chunk = ligne[93:94]
	   anorebong  = chunk.strip()
	   chunk  = ligne[94:98]
	   nutirebond =  chunk.strip()
	   chunk = ligne[98:100]
	   numerorebond = chunk.strip()
	   cur.execute("INSERT INTO pcta ( CCROLOP, CTCLI, CCROANOC, NCTANUTI, NCTALGNS, DTABVAL, CCTASNSE, CRGPTYPE, CCTADVAL, CCTAMAFI, LCTATARU, LCTARESU, CCTAECRM, NCTAJOUV, CSQLCLOP, CSQLTYP , CSQLANO , NSQLNUTI, NSQLLGNS, CCTAEXOC, CCTAALGO, CCTAREFN, CCTACLOP, CCTATYP , CCTAANOC, NCTANNUT, NCTANLGN)  VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)",(ope, typeclt, ano, nuti, numero, date, sens, gptype, dval, mafi, taru, resu, ecrm, jouv, sqlclop,sqltyp,sqlanoc, sqlnuti, sqllgns, exoc, algo, refn, operebond, typerebond, anorebong, nutirebond, numerorebond ))
conn.commit()
cur.close()
conn.close()
fo.close()
print(cp)
