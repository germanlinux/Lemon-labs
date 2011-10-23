(function() {
  var http, puts;
  http = require('http');
  puts = console.log;
  http.createServer(function(request, res) {
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
  }).listen(8090);
  puts("le serveur ecoute sur le port 8090");
}).call(this);
