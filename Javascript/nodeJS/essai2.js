// Generated by CoffeeScript 1.6.2
(function() {
  var board, five, myrandom, r1, r2, r3, sommeil;

  five = require("johnny-five");

  board = new five.Board();

  r1 = function() {
    var a;

    a = Math.floor(180 * Math.random());
    return a;
  };

  r2 = function() {
    var a;

    a = Math.floor(30 * Math.random()) + 85;
    return a;
  };

  r3 = function() {
    var a;

    return a = Math.floor(5000 * Math.random()) + 1000;
  };

  myrandom = function() {
    var bond;

    return bond = {
      x: r1(),
      y: r2(),
      t: r3()
    };
  };

  sommeil = function(mil) {
    var i, start, _i, _results;

    start = new Date().getTime();
    _results = [];
    for (i = _i = 0; 0 <= 1e7 ? _i <= 1e7 : _i >= 1e7; i = 0 <= 1e7 ? ++_i : --_i) {
      if ((new Date().getTime() - start) > mil) {
        break;
      } else {
        _results.push(void 0);
      }
    }
    return _results;
  };

  board.on("ready", function() {
    var myLed, myServoX, myServoY, servo, t;

    myServoX = new five.Servo(9);
    myServoY = new five.Servo({
      pin: 8,
      range: [95, 115]
    });
    myLed = new five.Led(7);
    board.repl.inject({
      servo: myServoX
    });
    board.repl.inject({
      servo: myServoY
    });
    servo = {
      servoX: myServoX,
      servoY: myServoY,
      led: myLed
    };
    board.repl.inject(servo);
    myLed.on();
    myServoY.center();
    myServoX.center();
    t = myrandom();
    console.log(t);
    myServoY.to(t.y);
    myServoX.to(t.x);
    return this.loop(5000, function() {
      t = myrandom();
      console.log(t);
      myServoY.to(t.y);
      return myServoX.to(t.x);
    });
  });

}).call(this);