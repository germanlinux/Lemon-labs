def fonct(valeur, a= None):
    if type(a) is list:
            a.append(valeur)
    #       a+= valeur
    elif type(a) is tuple:      
                a += tuple((valeur,))      
    elif type(a) is str:      
                a += str(valeur)    
    elif type(a) is set:      
                a.add(valeur)    
    else:
            a+= valeur
    return(a)

print(fonct(4, [1, 2, 3]))  # [1, 2, 3, 4]
print(fonct(4, 'eg' ))      # eg4
print(fonct(4, (1,2,3)))    # (1, 2, 3, 4)
print(fonct(4, {1, 2, 3}))  # (1, 2, 3, 4)


