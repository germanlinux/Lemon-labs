api_request= require ('api_request')
## definition de la fonction 
get_le_stock = ( lacle ) ->
  console.log("le debut fonction")
  r2  = new api_request('http', 'localhost', 8888)
  url = '/getValue?cle=' + lacle;
  r2.with_content_type('application/json')
    .get( url ).on('reply',
      (reply, res) -> 
            console.log('LA REPONSE DU GET:')
            console.log( reply )
            #console.log( 'suite')
            #console.log( res.statusCode )
      )
## programme principal 

console.log("Lancement du programme")
#for x in [0..1] 
# get_le_stock("cle#{x}")



get_le_stockSync = ( lacle,max ) ->
  return if lacle > max 
  console.log("le debut fonction: #{lacle}")
  r2  = new api_request('http', 'localhost', 8888)
  url = '/getValue?cle=' + lacle;
  r2.with_content_type('application/json')
    .get( url ).on('reply',
      (reply, res) -> 
            console.log('LA REPONSE DU GET SYNC:',reply)
           # console.log( 'suite')
           # console.log( res.statusCode )
            get_le_stockSync(lacle+1,max)
      )







get_le_stockSync(0,20)






#get_le_stock_async = (fct,xcp) ->
#       if xcp < 11 
#           fct("cle#{xcp}") 
#           get_le_stock_async(fct,xcp+1)
#      
#get_le_stock_async(get_le_stock,0)

