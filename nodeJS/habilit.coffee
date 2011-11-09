h = { result: 'ok',valeur: { user: 'jean.valjean',habilit: [ 'opera', 'monintranet' ] } }

z =  h['valeur']['habilit']
z ?= []
console.log z
if ('monintranet' in z)
     console.log 'present' 
if ('montrane' in z) 
       console.log 'erreur present' 

        

