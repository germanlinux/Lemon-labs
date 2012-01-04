jsdom = require('jsdom') 
fs    = require('fs')
api_request = require('api_request')
cpaverifier = 0
str_link =  fs.readFileSync "./lasuite.txt" , 'utf8'
tab_link = str_link.split('\n') 

if  !process.argv[2] 
     base = "/doc/unites_infradep/indicateurs_2012_unites_ref_fichiers/" 
else
     base  = process.argv[2] 


#console.log tab_link
jquery = fs.readFileSync("./jquery.js").toString()
cpx = 0
teste = (tab_of_link) ->
  for link in tab_of_link 
   if link.indexOf('RANGE') > 0
     cpaverifier = cpaverifier - 1
     cpx = cpx + 1
   else
    #   regep = new RegExp /^\.\./
    #   tlink = link.replace(regep,'')  
       r = new api_request('http', 'localhost', 8888) 
       r.get(base + link).on 'reply', (reply,res) -> 
#       console.log(res)
#        console.log res.request_options.path 
#        console.log(res.client._httpMessage.path)  
        if res.statusCode == 200 
            console.log res.client._httpMessage.path + ":---> " +  res.statusCode
        if res.statusCode == 200 
           cpx = cpx + 1 
           console.log(cp + "   " + cpx) 
           cpaverifier = cpaverifier - 1
           if cpaverifier == 0 
                console.log ('tout est ok')
cp = 0
for talink in tab_link
  do (talink) -> 
        jsdom.env({
                html: "http://localhost:8888" + talink ,
                src:  [jquery] ,
                done: (err,window) ->
                        $ = window.$
                        links=[] 
                        console.log("eg jquery")
                        console.log(talink + " nombre de lien :" + $("a").length)
                        cp = cp +  $("a").length
                        $("a").each -> links.push($(this).attr("href"))
                        teste(links)                       
           })  
 
