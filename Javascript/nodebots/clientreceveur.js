var mqtt = require('mqtt')
  , host = 'localhost'
  , port = '1883';

var settings = {
  keepalive: 1000,
  protocolId: 'MQIsdp',
  protocolVersion: 3,
  clientId: 'client-1'
}

// client connection
var client = mqtt.createClient(port, host, settings);

// client subscription
client.subscribe('laser/cat')
client.on('message', function(topic, message) {
  console.log('received', topic, message);
});