import pdftotext
import sys
#import glob
fichier = sys.argv[1]
#liste = glob.glob('*.pdf')
with open(fichier,'rb') as f:
    pdf = pdftotext.PDF(f)
print(len(pdf))
cp = 1
for page in pdf:
    print(f"-------------> {cp} <-------------------------")
    print(page)
    cp+=1
'''  
    if trouve == True :
        print( f"{fichier} fichier ok")
    else:
        print(f"{fichier} fichier ko")
'''