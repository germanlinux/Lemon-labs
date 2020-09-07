def fonct(valeur, a= None):
    if a is not None:
        try:
            a.append(valeur)
    #       a+= valeur
        except :
            try:        
                a += valeur
            except: 
                a = a + str(valeur)     
        else:
            None

    else:
        a = [valeur]
    return(a)

fonct(4, [1, 2, 3])
fonct(4, 'eg' )
fonct(4, (1,2,3))
fonct(4, {1, 2, 3})
