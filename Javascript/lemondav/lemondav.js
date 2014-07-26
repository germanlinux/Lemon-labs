// Generated by CoffeeScript 1.6.2
(function() {
  var fs, http, interface_reseau, internalMethods, key, methodes_impl, methods, port, resp_profind, server, st_test_reponse, str_methods, test_reponse, version;

  http = require('http');

  fs = require('fs');

  port = 7777;

  interface_reseau = '0.0.0.0';

  version = '0.0';

  internalMethods = {
    "OPTIONS": 1,
    "GET": 0,
    "HEAD": 0,
    "DELETE": 0,
    "PROPFIND": 0,
    "MKCOL": 0,
    "PUT": 0,
    "PROPPATCH": 0,
    "COPY": 0,
    "MOVE": 0,
    "REPORT": 0
  };

  str_methods = '';

  methods = [];

  for (key in internalMethods) {
    if (internalMethods[key] === 1) {
      str_methods += "" + key + " ";
      methods.push(key.toUpperCase());
    }
  }

  methodes_impl = methods.join(",");

  console.log("Methodes supportees: " + str_methods);

  str_methods = '';

  for (key in internalMethods) {
    if (internalMethods[key] === 0) {
      str_methods += "" + key + " ";
    }
  }

  console.log("Methodes non supportees: " + str_methods);

  resp_profind = fs.readFileSync('profind_response.xml');

  test_reponse = {
    reponse: "Reponse du serveur LemonDAV_V" + version + "  :OK"
  };

  st_test_reponse = JSON.stringify(test_reponse);

  server = http.createServer(function(req, res) {
    var headers, lg, message;

    console.log(req.method, req.url);
    res.on('data', function(chunk) {
      return console.log("BODY" + chunk.toString());
    });
    switch (req.method) {
      case 'OPTIONS':
        headers = {
          "Connection": "close",
          "Allow": methodes_impl,
          "MS-Author-Via": "DAV",
          "Accept-Ranges": "bytes",
          "X-LemonDAV-Version": version,
          "server": "LemonDAV_V" + version,
          "Content-Length": 0,
          "DAV": "1, 2, 3, calendar-access, extended-mkcol"
        };
        res.writeHead(200, headers);
        return res.end();
      case 'PROPFIND':
        message = resp_profind;
        lg = message.length;
        headers = {
          "Connection": "close",
          "Content-Length": lg,
          "DAV": "1, 2, 3, calendar-access, extended-mkcol",
          "content-Type": "text/xml",
          "server": "LemonDAV_V" + version
        };
        res.writeHead(207, headers);
        console.log(message);
        res.write(message);
        return res.end();
      default:
        message = st_test_reponse;
        lg = message.length;
        res.writeHead(200, {
          'content-Type': 'text/plain',
          'content-Length': lg
        });
        res.write(message);
        return res.end();
    }
  });

  server.listen(port, interface_reseau);

  console.log("Le serveur LemonDAV_V" + version + " lance sur le port " + port);

}).call(this);
