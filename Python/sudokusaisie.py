import pickle

matrice =[]
list_totale =[]
try:
  with  open('mypicklefile', 'rb') as pers:
      list_totale = pickle.load(pers)
  print(list_totale)
except:
    pass
    
classe = input('niveau: ')

for i in range(9):
    ligne= []
    cpj =0
    while cpj < 9 :
      print(ligne)
      a  =input()
      if a == "":
        a ='0'
      for li in a:
        ligne.append(int(li))
        print('ajout', li) 
        cpj +=1     
      
    matrice.append(ligne)

    for item in matrice:
        print(item)
    print(f"debut ligne: {i+2}")
# TODO 
# ajouter modif
rep = input("(v)alider (nb) modifier ") 
if rep.casefold() == 'v':   
    list_totale.append([classe, matrice])
    pickle.dump(list_totale, open('mypicklefile', 'wb'))
    print('sauvegarde OK')
else:
   nb = int(rep) 
   print(matrice[nb])
   ligne =[]
   for j in range(9):
      print(ligne)  
      a  =input()
      if a == "":
        a ='0'
      ligne.append(int(a))      
   matrice[nb] = ligne   
   list_totale.append([classe, matrice])
   pickle.dump(list_totale, open('mypicklefile', 'wb'))