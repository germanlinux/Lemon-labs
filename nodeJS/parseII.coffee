fs = require 'fs'
exec = require('child_process').exec
exec2 = require "sync-exec"
rep_collecte = "fichiers"
rep_tmp = "tmpegjs"
rep_ancien = "dejafait"
#Db = require('mongodb').Db
#Server = require('mongo').Server
MongoClient = require('mongodb').MongoClient
mydb={}
coll_archive = {}
coll_file    = {}
coll_diff    = {}
nbByteCftX   = 0
nbByteCftZ   = 0
nblineCftX   = 0
nblineCftZ   = 0
nbfileCftX   = 0
nbByteEdiX   = 0
nbfileCftZ   = 0
nbByteEdiZ   = 0
nblineEdiX   = 0
nblineEdiZ   = 0
nbfileEdiZ   = 0
nbfileEdiX   = 0
nbAbByteCftX = 0
nbAbByteCftZ = 0
nbAblineCftX = 0
nbAblineCftZ = 0
nbAbfileCftZ = 0
nbAbfileCftX = 0
nbAbByteEdiX = 0
nbAbByteEdiZ = 0
nbAblineEdiX = 0
nbAblineEdiZ = 0
nbAbfileEdiZ = 0
nbAbfileEdiX = 0


#fonctions
errorinsert = (err,rec)->
  if err
     throw err
  console.log "file added" 


raz_compteur= () -> 
         nbByteCftX   = 0
         nbByteCftZ   = 0
         nblineCftX   = 0
         nblineCftZ   = 0
         nbfileCftX   = 0
         nbByteEdiX   = 0
         nbfileCftZ   = 0
         nbByteEdiZ   = 0
         nblineEdiX   = 0
         nblineEdiZ   = 0
         nbfileEdiZ   = 0
         nbfileEdiX   = 0
         nbAbByteCftX = 0
         nbAbByteCftZ = 0
         nbAblineCftX = 0
         nbAblineCftZ = 0
         nbAbfileCftZ = 0
         nbAbfileCftX = 0
         nbAbByteEdiX = 0
         nbAbByteEdiZ = 0
         nbAblineEdiX = 0
         nbAblineEdiZ = 0
         nbAbfileEdiZ = 0
         nbAbfileEdiX = 0


readfile = (file) -> 
    cpligne = 0
    content= " "
    content = fs.readFileSync file
    scontent = content.toString()
    tab = scontent.split("\n")
    tab.length


sleep = (ms) ->
  start = new Date().getTime()
  continue while new Date().getTime() - start < ms

comptefile  = (path) ->
   tabfile =[] 
   files  = fs.readdirSync(path)
   for f in files
     if match = /\d+/.test(f)
     	tabfile.push(f)
   tabfile

explorerep = (path) ->
   tabfile =[] 
   files  = fs.readdirSync(path)
   for f in files
     if match = /\d+/.test(f)
       my_size = statSync(f).size
       #ici calcul du nombre de ligne 
        
compare = (tab)->
  cpok = 0
  cpinf = 0
  tabobj = []
  tabobj.results=[]
  tab.forEach (item) ->
      result = [] 
      objresult = {}
      objresult.zfile = item[0]
      objresult.xfile = item[1]
      objresult.z = item[2]
      objresult.x = item[3]
      objresult.limit=0
      objresult.ok = 0 
      ls = exec2("diff -u #{item[0]}  #{item[1]}")
      tabtmp = ls.stdout.split('\n')
      if tabtmp.length > 30
        tab2tmp= tabtmp[0..30]
        tab2tmp.push "TROP DE LIGNE"
        cpinf++
        objresult.limit = 1
      else
         tab2tmp = tabtmp
         objresult.limit = 0 
      if tab2tmp.length < 2
        cpok++   
      else  
        lg = tab2tmp.join('\n')
        result.push lg
        objresult.result = result
        tabobj.results.push objresult
  tabobj.ok = cpok
  tabobj.limit = cpinf 
  return tabobj
fermeture= ->
   mydb.close(true)

sup = exec2("rm -fr #{rep_tmp}-*")
sleep 5000
console.log "on commence"
mongocli = new  MongoClient.connect('mongodb://127.0.0.1/dblvfp', (err, db)->
       if (err) 
         throw 'serveur mondb non lance\n'
       mydb = db
       principale()
       setTimeout fermeture , 5000  
       )

principale= ()->
  tabfile =[]
  tar_opt = " -C #{rep_tmp}" 
  files  = fs.readdirSync(rep_collecte)
  for f in files
   if match = /fichiers.*tgz/.test(f)
      console.log "find #{f}"
      tabfile.push(rep_collecte+'/'+f)
  for f in tabfile 
    my_size = fs.statSync(f).size
    raz_compteur()
    nom_archive  = f.match(/\/(.+)/)[1]
    date_int= new Date()
    epoc_int = date_int.getTime()
    df = nom_archive.match(/(\d+)\.tgz/)[1]
    ma_date = df.match (/(\d{2})(\d{2})(\d{2})/)
    date_nom_file = new Date("20#{ma_date[1]}-#{ma_date[2]}-#{ma_date[3]}") 
    archivepath = rep_tmp + '-' + df 
    epoc_journee = date_nom_file.getTime()
    child = exec "mkdir #{archivepath}", (error, stdout, stderr) ->
        if error 
          throw (error)
    sleep(1000)
    child =    exec "tar -xvf #{f} -C #{archivepath}", (error, stdout, stderr) ->
        if error 
          throw (error)
    sleep(1000)
    fileZ = comptefile("#{archivepath}/file_z")
    nbfz = fileZ.length
    fileX = comptefile("#{archivepath}/file_x")
    nbfx = fileX.length
    archivee = 
      archive: nom_archive
      date: date_int 
      epoc: epoc_int
      date_journee: date_nom_file 
      epoc_journee: epoc_journee
      nb_fichier_z: nbfz
      nb_fichier_x: nbfx
      sdate: df
      date_passage: date_int
      epoc_passage: epoc_int    
      #console.log archivee 
      #calcul somme des fichiers
    tabfilez =[] 
    hashfilez = {}
    files  = fs.readdirSync("#{archivepath}/file_z")
    for g in files
     if match = /\d+/.test(g)
        atmp = g.split('_')
        tabfilez.push g
        ma_datef = atmp[0].match /(\d{2})(\d{2})(\d{2})/
        date_nom_filef = new Date "20#{ma_datef[1]}-#{ma_datef[2]}-#{ma_datef[3]}"  
        infile =
           fichiercomplet: g
           archive: nom_archive
           famille: atmp[2]
           host: atmp[1]
           fichier: atmp[4]
           chaine: atmp[3]
           occurs:  parseInt(atmp[5])
           date_journee: date_nom_filef
           epoc_journee: date_nom_filef.getTime()
           date_passage: date_int
           epoc_passage: epoc_int
        infile.ligne = readfile("#{archivepath}/file_z/#{g}")
        infile.size  = fs.statSync("#{archivepath}/file_z/#{g}").size
        hashfilez[g] = infile
        if atmp[2] == 'cft' 
          nbByteCftZ += infile.size
          nblineCftZ += infile.ligne
          nbfileCftZ += 1
        else
          nbByteEdiZ += infile.size
          nblineEdiZ += infile.ligne
          nbfileEdiZ += 1      
        console.log infile
        mydb.collection('file').insert(infile,errorinsert)
        sleep(1000)
    tabfilex = []
    hashfilex = {}    
    filesx  = fs.readdirSync("#{archivepath}/file_x")
    for h in filesx
      if match = /\d+/.test(h)
        atmp = h.split('_')
        tabfilex.push h
        ma_datef = atmp[0].match /(\d{2})(\d{2})(\d{2})/
        date_nom_filef = new Date "20#{ma_datef[1]}-#{ma_datef[2]}-#{ma_datef[3]}"  
        infile =
          fichiercomplet: h
          archive: nom_archive
          famille: atmp[2]
          host: atmp[1]
          fichier: atmp[4]
          chaine: atmp[3]
          occurs:  parseInt(atmp[5])
          date_journee: date_nom_filef
          epoc_journee: date_nom_filef.getTime()
          date_passage: date_int
          epoc_passage: epoc_int
        infile.ligne = readfile("#{archivepath}/file_x/#{h}")
        infile.size  = fs.statSync("#{archivepath}/file_x/#{h}").size
        hashfilex[h] = infile
        if atmp[2] == 'cft' 
          nbByteCftX += infile.size
          nblineCftX += infile.ligne
          nbfileCftX += 1
        else
         nbByteEdiX += infile.size
         nblineEdiX += infile.ligne
         nbfileEdiX += 1      
        console.log infile
        mydb.collection('file').insert(infile,errorinsert)
        sleep(1000)
    listXabsent=[] 
    for it in tabfilez 
      #console.log it
      fil = it.replace(/_z_/,'_x_')
      if !hashfilex[fil] 
         listXabsent.push it 
         filabs = hashfilez[it]
         if filabs.famille == 'cft'
           nbAbByteCftX += filabs.size
           nbAblineCftX += filabs.ligne
           nbAbfileCftX += 1 
         else
           nbAbByteEdiX += filabs.size
           nbAblineEdiX += filabs.ligne
           nbAbfileEdiX += 1  
         #console.log 'pas ok'
    console.log listXabsent 
    listZabsent=[] 
    for iu in tabfilex 
      #console.log iu
      filu = iu.replace(/_x_/,'_z_')
      if !hashfilez[filu] 
         listZabsent.push iu 
         filabs = hashfilex[iu]
         if filabs.famille == 'cft'
           nbAbByteCftZ += filabs.size
           nbAblineCftZ += filabs.ligne
           nbAbfileCftZ += 1 
         else
           nbAbByteEdiZ += filabs.size
           nbAblineEdiZ += filabs.ligne
           nbAbfileEdiZ += 1  
         #console.log 'pas ok'
    #console.log listZabsent 
    archivee.zabsent   = listZabsent
    archivee.xabsent   = listXabsent
    archivee.xligneedi = nblineEdiX
    archivee.xsizeedi  = nbByteEdiX
    archivee.xlignecft = nblineCftX
    archivee.xsizecft  = nbByteCftX
    archivee.zligneedi = nblineEdiZ
    archivee.zsizeedi  = nbByteEdiZ
    archivee.zlignecft = nblineCftZ
    archivee.zsizecft  = nbByteCftZ
    archivee.xabsligneedi = nbAblineEdiX
    archivee.xabssizeedi  = nbAbByteCftX
    archivee.xabslignecft = nbAblineCftX
    archivee.xabssizecft  =  nbAbByteCftX
    archivee.zabsligneedi = nbAblineEdiZ
    archivee.zabssizeedi  = nbAbByteEdiZ
    archivee.zabslignecft = nbAblineCftZ
    archivee.zabssizecft  =  nbAbByteCftZ
    archivee.zabsfilecft  =  nbAbfileCftZ
    archivee.zabsfileedi =  nbAbfileEdiZ
    archivee.xabfilecft  =  nbAbfileCftX
    archivee.xabfileedi  =  nbAbfileEdiX
    archivee.zfilecft    =  nbfileCftZ
    archivee.zfileedi    =  nbfileEdiZ
    archivee.xfilecft    =  nbfileCftX
    archivee.xfileedi    =  nbfileEdiX     
    tabfile2diff=[]
    for ifi in tabfilez 
      fil = ifi.replace(/_z_/,'_x_')
      if hashfilex[fil]
        tabfile2diff.push ["#{archivepath}/file_z/#{ifi}","#{archivepath}/file_x/#{fil}", ifi , fil]
    archivee.totaldiff = tabfile2diff.length
    #console.log tabfile2diff
    #lancer les comparaisons
    recup = compare(tabfile2diff)
    archivee.limit = recup.limit
    archivee.ok =    recup.ok
    console.log archivee
    #ecriture archive 
    #ecriture fichier (fait au fil de l'eau )
    #ecriture diff
    cpdiffcft=0
    cpdiffedi=0
    for diff in recup.results
     diffe =
       filez: diff.z
       filex: diff.x
       famille: hashfilez[diff.z].famille
       chaine: hashfilez[diff.z].chaine
       fichier: hashfilez[diff.z].fichier
       occurs: hashfilez[diff.z].occurs 
       nbdiff: diff.result.length
       tabdiff: diff.result
       limit: diff.limit
       archive: nom_archive
       date_journee:hashfilez[diff.z].date_journee
       epoc_journee: hashfilez[diff.z].epoc_journee
     console.log diffe
     if diffe.famille == 'cft'
       cpdiffcft++
     else 
       cpdiffedi++            
     mydb.collection('diff').insert(diffe,errorinsert)
     sleep(1000)
    archivee.diffcft = cpdiffcft
    archivee.diffedi = cpdiffedi
    mydb.collection('archive').insert(archivee,errorinsert)    
    sleep(1000) 
  for filex in  tabfile
    df = exec2("mv #{filex} #{rep_ancien}/")
    console.log "deplacement de #{filex}"

