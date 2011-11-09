(function() {
  var Validator, api_request, config, habilit, head, http, loginPortal, my_conf, my_cookie, puts;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  http = require('http');
  Validator = require('./authorization');
  config = require('./config.js');
  head = require('./header.js');
  api_request = require('api_request');
  puts = console.log;
  habilit = function(reply, res, auto, origine, loginPortal, codeappli, cookie) {
    console.log("dans habilit");
    console.log(reply);
    auto.compute(reply, origine, loginPortal, codeappli, cookie);
    console.log("en sortant d'habilit");
    return false;
  };
  puts("Lancement de lemonode");
  if (config.isDebugOn()) {
    puts("Debut chargement de la configuration");
  }
  my_conf = config.getConfigSync();
  if (config.isDebugOn()) {
    puts("acquisition de " + my_conf['global']['port']);
  }
  if (config.isDebugOn()) {
    puts("Fin chargement de la configuration");
  }
  if (config.isDebugOn()) {
    puts("Mise en service");
  }
  my_cookie = my_conf['global']['cookie'];
  loginPortal = my_conf['global']['portal'];
  http.createServer(__bind(function(request, response) {
    var HP, codeappli, config_location, headerRedirection, locationURL, my_headers, my_session, myvalidator, origine, origine2, origine64, r, saveHost, target, targetHost, targetPort;
    if (config.isDebugOn()) {
      puts("headers incoming:");
    }
    if (config.isDebugOn()) {
      puts(request.headers);
    }
    if (config.isDebugOn()) {
      puts(request);
    }
    origine = "http://" + request.headers['host'] + request.url;
    origine2 = "http://" + request.headers['host'] + request.url + "_cookie=" + my_cookie;
    if (config.isDebugOn()) {
      puts(request.connection.remoteAddress + ": " + request.method + " (HTTP method) " + request.url + " (url on) " + request.headers['host']);
    }
    HP = head.getHostPort(request.headers);
    saveHost = request.headers['host'];
    puts("Cible VIP: " + HP['host'] + " sur port " + HP['port']);
    config_location = my_conf[HP['host']];
    codeappli = config_location['authorization'];
    puts("core: codeappli => " + codeappli);
    try {
      targetPort = config_location['port'];
    } catch (error) {
      puts("Erreur la location n'existe pas ou est absente de l entete: " + HP['host']);
      return null;
    }
    myvalidator = new Validator;
    targetHost = config_location['hostname'];
    target = targetHost + ":" + targetPort;
    puts("Cible RIP :" + targetHost + " sur port " + targetPort);
    my_headers = head.cloneHeaders(request.headers, target);
    if (config.isDebugOn()) {
      puts("headers outcoming:");
    }
    if (config.isDebugOn()) {
      puts(my_headers);
    }
    my_session = head.getCookie(request.headers, my_cookie);
    if (my_session) {
      if (config.isDebugOn()) {
        puts("session Ok: " + my_session);
      }
      myvalidator.on('expired', function(redirection) {
        var headerRedirection;
        console.log("reprise de la boucle sur expiration");
        headerRedirection = {
          'location': redirection
        };
        response.writeHead(302, headerRedirection);
        response.end();
        return null;
      });
      myvalidator.on('no-auth', function(accessdeny) {
        console.log("reprise de la boucle no auth");
        response.writeHead(403);
        response.end();
        return null;
      });
      myvalidator.on('auth', function(accessdeny) {
        var proxy, proxy_request;
        console.log("reprise de la boucle auth");
        proxy = http.createClient(targetPort, targetHost);
        puts(" suite URL " + request.url);
        proxy_request = proxy.request(request.method, request.url, my_headers);
        console.log("suite de la boucle auth");
        console.log(proxy_request);
        proxy_request.addListener('response', __bind(function(proxy_response) {
          proxy_response.addListener('data', __bind(function(chunk) {
            return response.write(chunk, 'binary');
          }, this));
          proxy_response.addListener('end', __bind(function() {
            return response.end();
          }, this));
          puts("dans la reponse");
          return response.writeHead(proxy_response.statusCode, myHeadersOut);
        }, this));
        request.addListener('data', __bind(function(chunk) {
          return proxy_request.write(chunk, 'binary');
        }, this));
        request.addListener('end', __bind(function() {
          return proxy_request.end();
        }, this));
        return console.log("SUITE de la boucle auth");
      });
      r = new api_request('http', 'localhost', 8888);
      r.with_content_type('application/json').with_payload({
        'cle': my_session
      }).post('/getValue').on('reply', function(reply, res) {
        return habilit(reply, res, myvalidator, origine, loginPortal, codeappli, my_cookie);
      });
      return puts("ok je suis passe");
    } else {
      puts("session failed cookie");
      origine64 = new Buffer(origine2);
      locationURL = loginPortal + "?url=" + origine64.toString('base64');
      puts("Location de redirection: " + locationURL);
      headerRedirection = {
        'location': locationURL
      };
      response.writeHead(302, headerRedirection);
      response.end();
      return null;
    }
  }, this)).listen(my_conf['global']['port']);
  puts("le serveur lemon:nodeJS V0.0 ecoute sur le port " + my_conf['global']['port'] + " ");
}).call(this);
