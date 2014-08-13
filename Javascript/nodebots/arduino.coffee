five = require "johnny-five"
mqtt = require 'mqtt'
mosca_host = 'localhost'
mosca_port = '1883'
client_settings = 
  keepalive: 1000
  protocolId: 'MQIsdp'
  protocolVersion: 3
  clientId: 'client-ard'

board = new five.Board()
client = mqtt.createClient mosca_port, mosca_host, client_settings
reg  = /(\w+):(\d+)/ 
tab = reg.exec("vertical:123");  
board.on  "ready", ()-> 
  myServoX = new five.Servo 9
  myServoY = new five.Servo(pin: 8 , range: [ 70, 115 ])
  myLed = new five.Led 7
 # board.repl.inject servo: myServoX
 # board.repl.inject servo: myServoY
 # servo = 
 #   servoX:   myServoX
 #   servoY:   myServoY 
 #   led   :   myLed
  client.subscribe 'laser/cat'
  client.on 'message', (topic, message) ->
    console.log 'received', topic, message
    console.log( typeof message)
    tab = reg.exec(message)  
    ordre = tab[1] 
    too = tab[2]
    console.log ordre
    console.log too
    if ordre == "axex" 
       myServoX.to(too)
    if ordre == "axey" 
       myServoY.to(too)
    if ordre == "laser" 
       if too == '1' 
         myLed.on() 
       else 
         myLed.off()            
    console.log( typeof too)
#    myLed.off() 
    myServoY.to(too) 
#  board.repl.inject servo
  myLed.on()
  myServoY.center()
  myServoX.center()
    
     