a = [1, 2, 3, 'e']
b = a
print(id(a), id(b))
print(a)
print(b)
a[1]  = 'couac'
print(b) 

##########################
a = [1, 2, 3, 'e']
b = a
a += ['fin']
print('a', a)
print('b', b)

at = (1, 2, 3, 'e')
bt = at
at += ('fin',)
print('at', at)
print('bt', bt)
