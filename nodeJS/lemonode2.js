(function() {
  var Validator, api_request, config, habilit, head, http, loginPortal, my_conf, my_cookie, puts, version;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  http = require('http');
  Validator = require('./authorization');
  config = require('./config.js');
  head = require('./headers.js');
  api_request = require('api_request');
  puts = console.log;
  habilit = function(reply, res, auto, origine, loginPortal, codeappli, cookie) {
    console.log("dans habilit");
    console.log(reply);
    auto.compute(reply, origine, loginPortal, codeappli, cookie);
    return console.log("en sortant d'habilit");
  };
  version = "0.0";
  if (config.getVersion()) {
    puts("v" + version);
    return null;
  }
  puts("Lancement de lemon:nodeJS");
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
    var HP, codeappli, config_location, headerRedirection, locationURL, my_headers, my_session, myvalidator, origine, origine2, origine64, r, saveHost, state, target, targetHost, targetPort;
    puts("request incoming:" + request.url);
    if (config.isDebugOn()) {
      puts("headers incoming:");
    }
    if (config.isDebugOn()) {
      puts(request.headers);
    }
    if (config.isDebugOn()) {
      puts(request);
    }
    state = [];
    origine = "http://" + request.headers['host'] + request.url;
    origine2 = origine + "_cookie=" + my_cookie;
    state['end'] = 0;
    if (config.isDebugOn()) {
      puts(request.connection.remoteAddress + ": " + request.method + " (HTTP method) " + request.url + " (url on) " + request.headers['host']);
    }
    HP = head.getHostPort(request.headers);
    saveHost = request.headers['host'];
    request.addListener('end', function() {
      return state['end'] = 1;
    });
    puts("Cible VIP: " + HP['host'] + " sur port " + HP['port']);
    config_location = my_conf[HP['host']];
    codeappli = config_location['authorization'];
    puts("dispatcher: codeappli => " + codeappli);
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
        response.writeHead(403);
        response.end();
        return null;
      });
      myvalidator.on('auth', function(entete) {
        var add_header, proxy, proxy_request;
        add_header = head.addHeaders(my_headers, entete);
        my_headers = add_header;
        proxy = http.createClient(targetPort, targetHost);
        proxy_request = proxy.request(request.method, request.url, my_headers);
        proxy_request.addListener('response', __bind(function(proxy_response) {
          var headers_retour;
          headers_retour = head.cloneHeaders(proxy_response.headers, saveHost);
          response.writeHead(proxy_response.statusCode, headers_retour);
          proxy_response.addListener('data', __bind(function(chunk) {
            return response.write(chunk, 'binary');
          }, this));
          return proxy_response.addListener('end', __bind(function() {
            return response.end();
          }, this));
        }, this));
        if (state['end'] === 0) {
          return request.addListener('end', function() {
            return proxy_request.end();
          });
        } else {
          return proxy_request.end();
        }
      });
      r = new api_request('http', 'localhost', 8888);
      return r.with_content_type('application/json').with_payload({
        'cle': my_session
      }).post('/getValue').on('reply', function(reply, res) {
        return habilit(reply, res, myvalidator, origine, loginPortal, codeappli, my_cookie);
      });
    } else {
      puts("echec sur la récuperation de la session");
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
  puts("le serveur lemon:nodeJS V" + version + " ecoute sur le port " + my_conf['global']['port'] + " ");
}).call(this);
