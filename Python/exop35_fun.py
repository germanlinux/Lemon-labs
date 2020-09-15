def facade(func):
    def wrapper( *args, **kwargs):
        print('je passe:')
        if len(args) <2 :
            return ("operation non supportee")
        else:
            return(func(*args, **kwargs))
    return wrapper
@facade
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


print(fonct(4, 'eg'))
print(fonct(4))