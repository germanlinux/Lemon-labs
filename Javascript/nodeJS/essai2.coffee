five = require "johnny-five"
board = new five.Board()
r1 = () ->
  a= Math.floor( 180 * Math.random() ) 
  return a
r2 = () ->
  a= Math.floor( 30 * Math.random() ) + 85 
  return a
r3 = () -> 
   a = Math.floor( 5000 * Math.random() ) + 1000
myrandom  = () ->
   bond = 
    x: r1()
    y: r2()
    t: r3() 
sommeil = (mil) -> 
   start = new Date().getTime();
   for i in [0..1e7] 
     if ((new Date().getTime() - start) > mil)
            break
       

board.on  "ready", ()-> 
  myServoX = new five.Servo 9
  myServoY = new five.Servo(pin: 8 , range: [ 95, 115 ])
  myLed = new five.Led 7
  board.repl.inject servo: myServoX
  board.repl.inject servo: myServoY
  servo = 
    servoX:   myServoX
    servoY:   myServoY 
    led   :   myLed
  board.repl.inject servo
  myLed.on()
  myServoY.center()
  myServoX.center()
  t = myrandom()
  console.log t
  myServoY.to(t.y)
  myServoX.to(t.x)

  @.loop 5000, ()->
    t = myrandom()
    console.log t
    myServoY.to(t.y)
    myServoX.to(t.x)
    
     