(function() {
  var config, debug, head, http, loginPortal, my_conf, my_cookie, puts;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  http = require('http');
  config = require('./config.js');
  head = require('./header.js');
  debug = true;
  puts = console.log;
  puts("Lancement de lemonode");
  puts("Debut chargement de la configuration");
  my_conf = config.getConfigSync();
  puts("acquisition de " + my_conf['global']['port']);
  puts("Fin chargement de la configuration");
  puts("Mise en service");
  my_cookie = my_conf['global']['cookie'];
  loginPortal = my_conf['global']['portal'];
  http.createServer(__bind(function(request, response) {
    var HP, config_location, headerRedirection, locationURL, my_headers, my_session, origine, origine64, proxy, proxy_request, target, targetHost, targetPort;
    if (debug) {
      puts("headers incoming:");
    }
    if (debug) {
      puts(request.headers);
    }
    if (debug) {
      puts(request);
    }
    origine = "http://" + request.headers['host'] + request.url;
    if (debug) {
      puts(request.connection.remoteAddress + ": " + request.method + " (HTTP method) " + request.url + " (url on) " + request.headers['host']);
    }
    HP = head.getHostPort(request.headers);
    puts("Cible VIP: " + HP['host'] + " sur port " + HP['port']);
    config_location = my_conf[HP['host']];
    targetPort = config_location['port'];
    targetHost = config_location['hostname'];
    target = targetHost + ":" + targetPort;
    puts("Cible RIP :" + targetHost + " sur port " + targetPort);
    my_headers = head.cloneHeaders(request.headers, target);
    if (debug) {
      puts("headers outcoming:");
    }
    if (debug) {
      puts(my_headers);
    }
    my_session = head.getCookie(request.headers, my_cookie);
    if (my_session) {
      puts("session Ok");
    } else {
      puts("session failed cookie");
      origine64 = new Buffer(origine);
      locationURL = loginPortal + "?url=" + origine64.toString('base64');
      puts("Location de redirection: " + locationURL);
      headerRedirection = {
        'location': locationURL
      };
      response.writeHead(302, headerRedirection);
      response.end();
    }
    proxy = http.createClient(targetPort, targetHost);
    proxy_request = proxy.request(request.method, request.url, my_headers);
    proxy_request.addListener('response', __bind(function(proxy_response) {
      proxy_response.addListener('data', __bind(function(chunk) {
        return response.write(chunk, 'binary');
      }, this));
      proxy_response.addListener('end', __bind(function() {
        return response.end();
      }, this));
      return response.writeHead(proxy_response.statusCode, proxy_response.headers);
    }, this));
    request.addListener('data', __bind(function(chunk) {
      return proxy_request.write(chunk, 'binary');
    }, this));
    return request.addListener('end', __bind(function() {
      return proxy_request.end();
    }, this));
  }, this)).listen(my_conf['global']['port']);
  puts("le serveur ecoute sur le port " + my_conf['global']['port'] + " ");
}).call(this);
