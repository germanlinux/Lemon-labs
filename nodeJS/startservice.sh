# Lancement du identify provider 
cd ./identityprovider
node servidp.js &
# lancement du stockage nosql
cd ..
node stocker.js &
node essaihttp.js &

