var mqtt = require('mqtt')
  , host = 'localhost'
  , port = '1883';

var settings = {
  keepalive: 1000,
  protocolId: 'MQIsdp',
  protocolVersion: 3,
  clientId: 'client-2'
}

// client connection
client = mqtt.createClient(port, host, settings);

// client publishing a sample JSON
client.publish('hello/you', '{ "hell": "you" }', {qos:1, retain:true} );
client.publish('hello/you', '{ "hellx": "you" }', {qos:1, retain:true} );