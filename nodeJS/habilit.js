(function() {
  var h, z, _base;
  var __indexOf = Array.prototype.indexOf || function(item) {
    for (var i = 0, l = this.length; i < l; i++) {
      if (this[i] === item) return i;
    }
    return -1;
  };
  h = {
    result: 'ok',
    valeur: {
      user: 'jean.valjean',
      habilit: ['opera', 'monintranet']
    }
  };
  z = typeof (_base = h['valeur'])['habilit'] === "function" ? _base['habilit']([]) : void 0;
  if ((__indexOf.call(z, 'montranet') >= 0)) {
    console.log('present');
  }
  if ((__indexOf.call(z, 'montrane') >= 0)) {
    console.log('erreur present');
  }
}).call(this);
