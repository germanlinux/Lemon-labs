####  exemple 1
def fonct():
    print(a)


a = 10
fonct()

####  exemple 2

def fonct():
    b = 4
    print(a)
    print(b)
    
a = 10
fonct()
print(b)

####  exemple 3
def fonct():
	a = 5
	print('var a dans fonct' , a)

a = 10
print('var a en debut' , a)	
fonct()
print(a)
print('var a en fin' , a)	

####  exemple 4

def fonct():
    b = 4
    a = 5
    print(a)
    print(b)

a = 15
fonct()
print(a)


####  exemple 5

def fonct():
    print(a)
    a = 20
    
a = 10
fonct()
print(a)

####  exemple 6

def fonct():
	global a
    print(a)
    a = 20
    
a = 10
fonct()
print(a)