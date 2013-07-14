#! /bin/sh
    CONF=/home/german/local/etc/conf/mongodb.conf
do_start () {
echo  "Starting mongo with-> /usr/local/bin/mongod -config $CONF"
echo "checking if mongo is running"
PID=$(cat /home/german/labo/mongodb-linux-i686-2.2.2/data/db/mongod.lock)
if [ ! -z "$PID" ];
then
echo "mongod is running, no need to start"
exit
fi
echo " it isn't"


mongod -config $CONF

    }
do_stop () {
echo "checking if mongo is running"
PID=$(cat /home/german/labo/mongodb-linux-i686-2.2.2/data/db/mongod.lock)
if [ -z "$PID" ];
then
echo "mongod isnt running, no need to stop"
exit
fi
echo " it is"
echo "Stopping mongo with-> /bin/kill -2 $PID"
/bin/kill -2 $PID
}
case "$1" in
start)
do_start
;;
stop)
do_stop
;;
*)

        echo "Usage: $0 start|stop" >&2
        exit 3
        ;;
    esac
