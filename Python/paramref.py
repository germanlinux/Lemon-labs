a = [1, 2, 3, 'e']
def fonct(b):
     b[1] = 'edb'

fonct(a)
print('a', a)

def fonctsafe(b):
    c = list(b) 
    c[1] = 'edb'

a = [1, 2, 3, 'e']    
fonctsafe(a)
print('a', a)    
       