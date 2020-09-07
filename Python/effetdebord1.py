''' Exemple de fonction avec effet de bord:
    la liste par defaut est initialisee au 
    momemt de la declaration de la fonction
    sortie pylint:
    effetdebord1.py:6:0: W0102: Dangerous default value [] as argument (dangerous-default-value)

'''

def fonct(valeur, a=[]):
    a.append(valeur)
    return(a)

res = fonct(4)
print(res)                   # [4]
res = fonct(5, [1, 2, 3, 4]) 
print(res)                   # [1, 2, 3, 4, 5]
res = fonct(4)
print(res)                   # [4, 4]  Erreur !


### solutinon

def fonct(valeur, a= None):
    if a is not None:
        a.append(valeur)
    else:
        a = [valeur]
    return(a)

res = fonct(4)
print(res)                   # [4]
res = fonct(5, [1, 2, 3, 4]) 
print(res)                   # [1, 2, 3, 4, 5]
res = fonct(4)
print(res)                   # [4]  OK !