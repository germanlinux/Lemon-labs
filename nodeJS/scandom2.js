(function() {
  var api_request, base, cp, cpaverifier, cpx, fs, jquery, jsdom, str_link, tab_link, talink, teste, _fn, _i, _len;
  jsdom = require('jsdom');
  fs = require('fs');
  api_request = require('api_request');
  cpaverifier = 0;
  str_link = fs.readFileSync("./lasuite.txt", 'utf8');
  tab_link = str_link.split('\n');
  if (!process.argv[2]) {
    base = "/doc/unites_infradep/indicateurs_2012_unites_ref_fichiers/";
  } else {
    base = process.argv[2];
  }
  jquery = fs.readFileSync("./jquery.js").toString();
  cpx = 0;
  teste = function(tab_of_link) {
    var link, r, _i, _len, _results;
    _results = [];
    for (_i = 0, _len = tab_of_link.length; _i < _len; _i++) {
      link = tab_of_link[_i];
      _results.push(link.indexOf('RANGE') > 0 ? (cpaverifier = cpaverifier - 1, cpx = cpx + 1) : (r = new api_request('http', 'localhost', 8888), r.get(base + link).on('reply', function(reply, res) {
        if (res.statusCode === 200) {
          console.log(res.client._httpMessage.path + ":---> " + res.statusCode);
        }
        if (res.statusCode === 200) {
          cpx = cpx + 1;
          console.log(cp + "   " + cpx);
          cpaverifier = cpaverifier - 1;
          if (cpaverifier === 0) {
            return console.log('tout est ok');
          }
        }
      })));
    }
    return _results;
  };
  cp = 0;
  _fn = function(talink) {
    return jsdom.env({
      html: "http://localhost:8888" + talink,
      src: [jquery],
      done: function(err, window) {
        var $, links;
        $ = window.$;
        links = [];
        console.log("eg jquery");
        console.log(talink + " nombre de lien :" + $("a").length);
        cp = cp + $("a").length;
        $("a").each(function() {
          return links.push($(this).attr("href"));
        });
        return teste(links);
      }
    });
  };
  for (_i = 0, _len = tab_link.length; _i < _len; _i++) {
    talink = tab_link[_i];
    _fn(talink);
  }
}).call(this);
