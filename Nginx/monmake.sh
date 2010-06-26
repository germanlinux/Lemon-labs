make clean
./configure  --with-debug --with-http_stub_status_module  --add-module=/usr/local/nginxsandbox/
make
make install
cp /root/nginx.conf /usr/local/nginx/conf/
kill `cat /usr/local/nginx/logs/nginx.pid`
sleep 3
/usr/local/nginx/sbin/nginx
> /usr/local/nginx/logs/error.log

