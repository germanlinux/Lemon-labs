(function() {
  var api_request, base, cpaverifier, fs, jquery, jsdom, links, nomf, pageHTML, teste;
  jsdom = require('jsdom');
  fs = require('fs');
  api_request = require('api_request');
  cpaverifier = 0;
  if (!process.argv[2]) {
    throw "il faut indiquer un nom de fichier";
  } else {
    nomf = process.argv[2];
  }
  if (!process.argv[3]) {
    base = "/doc/";
  } else {
    base = process.argv[3];
  }
  teste = function(tab_of_link) {
    var link, r, suite, _i, _len, _results;
    suite = [];
    _results = [];
    for (_i = 0, _len = tab_of_link.length; _i < _len; _i++) {
      link = tab_of_link[_i];
      r = new api_request('http', 'localhost', 8888);
      _results.push(r.get(base + link).on('reply', function(reply, res) {
        var stlink;
        console.log(res.client._httpMessage.path + ":---> " + res.statusCode);
        if (res.statusCode === 200) {
          cpaverifier = cpaverifier - 1;
          if (cpaverifier === 0) {
            console.log('tout est ok');
            if (suite.length > 0) {
              console.log(suite);
              stlink = suite.join('\n');
            }
            fs.writeFile('/home/german/lasuite.txt', stlink, 'utf8', function(err) {
              if (err) {
                throw err;
              }
              return console.log('Saved.');
            });
          }
          if (link.indexOf('.htm') > 0) {
            console.log("attention document intermediaire");
            return suite.push(res.client._httpMessage.path);
          }
        }
      }));
    }
    return _results;
  };
  links = [];
  jquery = fs.readFileSync("./jquery.js").toString();
  pageHTML = fs.readFileSync(nomf, 'ascii');
  jsdom.env({
    html: pageHTML,
    src: [jquery],
    done: function(err, window) {
      var $;
      $ = window.$;
      console.log("eg jquery");
      console.log("nombre de lien :" + $("a").length);
      cpaverifier = $("a").length;
      if (cpaverifier > 0) {
        $("a").each(function() {
          return links.push($(this).attr("href"));
        });
      } else {
        $("link").each(function() {
          var tlink;
          tlink = $(this).attr("href");
          console.log(tlink);
          if (tlink.indexOf('.htm') >= 0) {
            links.push(tlink);
            cpaverifier += 1;
            return console.log(cpaverifier);
          }
        });
      }
      return teste(links);
    }
  });
}).call(this);
