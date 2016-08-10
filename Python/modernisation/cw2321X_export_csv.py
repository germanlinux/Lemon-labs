fs = open("./pseudoEG.csv","w")
fo = open("./pseudoEG.txt","r",encoding='windows-1252',errors='ignore')
cp = 0
for ligne in fo:
       #print(cp)
       cp +=1
       numdep   = ligne[0:3]
       spsencpt = ligne[3:14]
       dcroope  = ligne[14:22]
       ncrooper = ligne[22:27]
       ccrolop  = ligne[27:30]
       nheclgsc = ligne[30:32]
       poste    = ligne[32:35]
       cleycte  = ligne[36:41]
       dheccomp = ligne[41:49]
       cpseccli = ligne[49:50]
       cpsecoma = ligne[50:51]
       cpseimpe = ligne[51:52]
       dcroval  = ligne[52:60]
       MHECMNT  = ligne[60:75]
       CHECSNS  = ligne[75:76]
       SHEC1LIB = ligne[76:106]
       SHEC1LIB = SHEC1LIB.replace('"','\'')
       SHEC1LIB = SHEC1LIB.replace(chr(189),chr(733))
       SHEC1LIB =''
       lheclibe = ligne[106:136]
       lheclibe = lheclibe.replace(chr(189),chr(733))
       lheclibe=''
       lheclib2 = ligne[136:166]
       lheclib2=''
       ccrosche = ligne[166:167]
       checexo = ligne[167:168]
       checnot = ligne[168:169]
       ccroden = ligne [169:173]
       dcroden = ligne [173:181]
       ncroden = ligne [181:186]
       lhecspe1 = ligne[186:198]
       lhecspe2 = ligne[198:204]
       cpsergp = ligne[204:205]
       dcroref = ligne[205:213]
       ncroref = ligne[213:218]
       checerel = ligne[218:219]
       checelch  = ligne[219:220]
       nhecrged = ligne[220:225]
       ccroeuro = ligne[225:226]
       if ccrolop == '917':
         print('eg')
       print("{};{};{};{};{};{};{};{};{};{};{};{};{};{};{};{};{};{};{};{};{};{};{};{};{};{};{};{};{};{};{};{};{};".format(numdep  ,spsencpt,dcroope ,ncrooper,ccrolop ,nheclgsc,poste   ,cleycte ,dheccomp,cpseccli,cpsecoma,cpseimpe, dcroval , MHECMNT, CHECSNS, SHEC1LIB, lheclibe,lheclib2, \
       ccrosche, checexo, checnot, ccroden , dcroden, ncroden , lhecspe1 ,  lhecspe2, cpsergp, dcroref,ncroref, checerel, checelch ,nhecrged , ccroeuro   ),file=fs)
fo.close()
fs.close()
print(cp)

