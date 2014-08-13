var mosca = require('mosca');
var mqtt  = require('mqtt');

var brokerOpts = {
    port: 1883
};

var persistenceOpts = {
    url:'mongodb://localhost/mqttPersistence'
}

var broker = mosca.Server(brokerOpts);

broker.on('ready', function(){
    console.log('Broker ready')
});

broker.on('published', function(packet, client){
    console.log('Packet:', packet.payload);
});

var onPersistenceReady = function()
{
    console.log('Persistence Ready');
    persistence.wire(broker);
}

var persistence = mosca.persistence.Mongo(persistenceOpts, onPersistenceReady );
