(function() {
  exports.getHostPort = function(header) {
    var T, r;
    T = String(header.host).split(':');
    r = {};
    r.host = T[0];
    if (T[1]) {
      r.port = T[1];
    } else {
      r.port = 80;
    }
    return r;
  };
  exports.getCookie = function(header, name) {
    var book, cook, cp, reg, tmpcook;
    if (!header.cookie) {
      return false;
    }
    console.log(header.cookie);
    cook = String(header.cookie).split(';');
    cp = 0;
    while (cp < cook.length) {
      book = cook[cp].split('=');
      tmpcook = book[0];
      reg = /^ +/;
      tmpcook = tmpcook.replace(reg, '');
      if (tmpcook === name) {
        return book[1];
      }
      cp++;
    }
    return false;
  };
  exports.cloneHeaders = function(header, myhost) {
    var T, tmp;
    tmp = header;
    T = String(myhost).split(':');
    if (T[1] === 80) {
      tmp['host'] = T[0];
    } else {
      tmp['host'] = myhost;
    }
    return tmp;
  };
  exports.addHeaders = function(headers, entete) {
    var tmp;
    tmp = headers;
    tmp['authorization'] = entete;
    return tmp;
  };
}).call(this);
