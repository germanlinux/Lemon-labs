#!/usr/bin/python
import sys
import time
cp = 1
while True: 
    sys.stdout.write(("Boucle %d \n") % (cp))
    if cp % 10 == 0: 
        sys.stderr.write(("Erreur %d \n") % (cp))
    time.sleep(1)
    cp += 1
