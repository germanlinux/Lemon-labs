import sys
taille= int(sys.argv[2])
nom = sys.argv[1]

def read_in_chunks(file, chunk_size=1024):
    """Lazy function (generator) to read a file piece by piece.
    Default chunk size: 1k."""
    while True:
        data = file.read(chunk_size)
        if not data:
            break
        yield data

cp = 1
try: 
    f = open(nom,'rb')
except:
    print(f"fichier {nom} : introuvable")
    exit()    
for piece in read_in_chunks(f,taille):
   print(f"block:{cp} - taille: {len(piece)}")
   cp +=1

