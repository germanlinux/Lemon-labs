# Lancement du identify provider 
cd ./idp
node servidp.js &
# lancement du stockage nosql
cd ..
node stocker.js &
node essaihttp.js &

