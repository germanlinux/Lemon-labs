var five = require("johnny-five"),
    board, myServoH, myServoV;

board = new five.Board();

board.on("ready", function() {

  myServoH = new five.Servo(9);
  myServoV = new five.Servo(8);

  board.repl.inject({
    servoH: myServoH, 
    servoV: myServoV
  });

  
  myServoH.sweep();
  myServoV.sweep();

  this.wait(5000, function(){
    myServoH.stop();
    myServoH.center();
    myServoV.stop();
    myServoV.center();

  });
  

});