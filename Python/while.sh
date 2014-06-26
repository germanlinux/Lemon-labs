cp=0
while [ 1 ] 
do 
  echo "boucle sur STDOUT" $cp
  if [ $(( $cp % 10 )) = 0 ]
  then 
    echo "Erreur sur STDERR" $cp  >&2
  fi 
  ((cp+=1))

done   