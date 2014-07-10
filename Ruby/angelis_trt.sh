#!/bin/bash
#ls -1 *sql|xargs -t -n 1 cat   |sed s/e/o/g > $1.old
#reg = '(.+\.).+$'
for f in `ls -1 SQL_AVANT/*sql` 
  do 
    echo $f
    if [[ "$f" =~(.+)\.(.+)$ ]] 
    then     
        fic="${BASH_REMATCH[1]}"
        ext="${BASH_REMATCH[2]}"
    fi 
    echo $fic
    nom=$fic"_v63."$ext
    cat $f |sed s/estouvert/isdossiercree/g > $nom 
  done
