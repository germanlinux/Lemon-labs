(function() {
  var http, puts;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  http = require('http');
  puts = console.log;
  http.createServer(__bind(function(request, res) {
    var buffer, k, message;
    message = "<h1>hello lemonode</h1>";
    buffer = request.headers;
    puts(buffer);
    puts(buffer['host']);
    for (k in buffer) {
      message += "<p>" + k + "===>" + buffer[k] + "</p>";
    }
    res.writeHead(200, {
      'Content-Type': 'text/html',
      'Content-length': message.length
    });
    res.write(message);
    res.end();
    return puts("requete:" + request.url);
  }, this)).listen(8090);
  puts("le serveur ecoute sur le port 8090");
}).call(this);
