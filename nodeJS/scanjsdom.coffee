jsdom = require('jsdom') 
fs    = require('fs')
api_request = require('api_request')

cpaverifier = 0
if  !process.argv[2] 
    throw "il faut indiquer un nom de fichier"
else
    nomf = process.argv[2] 
if  !process.argv[3] 
     base = "/doc/" 
else
     base  = process.argv[3] 


teste = (tab_of_link) ->
  suite = []
  for link in tab_of_link 
       r = new api_request('http', 'localhost', 8888) 
       r.get(base + link).on 'reply', (reply,res) -> 
#         console.log(res)
#         console.log res.request_options.path 
#        console.log(res.client._httpMessage.path)  
        console.log res.client._httpMessage.path + ":---> " +  res.statusCode
        if res.statusCode == 200 
           cpaverifier = cpaverifier - 1
#           console.log (cpaverifier)    
           if cpaverifier == 0 
                console.log ('tout est ok')
                if suite.length > 0 
                         console.log(suite) 
                         stlink = suite.join('\n')  
                        fs.writeFile '/home/german/lasuite.txt', stlink, 'utf8', (err) ->  
                                 if (err) then  throw  err
                                 console.log('Saved.')  
           if link.indexOf('.htm') > 0
               console.log("attention document intermediaire")             
               suite.push res.client._httpMessage.path
         
 
 

links=[]
jquery = fs.readFileSync("./jquery.js").toString()
pageHTML = fs.readFileSync nomf,'ascii'
jsdom.env({
        html: pageHTML ,
        src:  [jquery] ,
        done: (err,window) ->
              $ = window.$
              console.log("eg jquery")
              console.log("nombre de lien :" + $("a").length)
              cpaverifier =   $("a").length
              if cpaverifier > 0
                 $("a").each -> links.push($(this).attr("href"))
              else 
#                 cpaverifier =  $("link").length
                 $("link").each -> 
                         tlink = $(this).attr("href")  
                         console.log(tlink)
                         if  tlink.indexOf('.htm') >= 0
                                 links.push(tlink) 
                                 cpaverifier += 1
                                 console.log(cpaverifier)
     

              teste(links)                       
        })
 
