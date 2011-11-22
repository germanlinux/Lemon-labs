exports.getHostPort =  ( header ) -> 
     T = String( header.host ).split( ':' )
     r = {}
     r.host = T[0]
     if  T[1] 
      r.port = T[ 1 ]
     else 
      r.port = 80
     return r

exports.getCookie = ( header, name ) ->
  if  !header.cookie 
    return false

  console.log(header.cookie)
  cook = String( header.cookie ).split(';')
#  console.log(cook)
  cp= 0;
  while (cp < cook.length ) 
     book = cook[ cp ].split('=')
     tmpcook = book[ 0 ] 
     reg = /^ +/
     tmpcook= tmpcook.replace(reg,'');
     if (tmpcook == name)
        return book[ 1 ]
     cp++ 
  return false

exports.cloneHeaders = ( header, myhost ) ->
  tmp     = header  
  T = String( myhost ).split( ':' )
  if (T[1] == 80) 
        tmp['host'] = T[0]
  else 
    tmp['host'] = myhost
  return tmp;      


exports.addHeaders = ( headers, entete ) ->
  tmp     = headers  
  tmp['authorization'] = entete 
  return tmp      
exports.ajustLocation = (hd,target,origine,port) ->
  console.log(hd) 
  console.log(target)
  console.log(origine)
  reg = target
  if  port != 80 
      origine = origine + ":" + port
  hd = hd.replace(reg,origine)
  console.log(hd)
  return hd 
