(function() {
  var config, my_conf, my_host, puts, test;
  config = require('./../config.js');
  puts = console.log;
  test = "lecture fichier de configuration";
  puts("test " + test);
  my_conf = config.getConfigSync();
  if (my_conf['global']['port'] === 8080) {
    puts("" + test + " :OK");
  } else {
    puts("" + test + " :FAILED !!!!! => " + my_conf['global']['port'] + " <=> 8080 ");
  }
  puts("--------------------------------------------------------------------");
  test = "recup host-1";
  puts("test " + test);
  my_host = config.getCible('localhost');
  if (my_host === "localhost:8090") {
    puts("" + test + " :OK");
  } else {
    puts("" + test + " :FAILED !!!!! => " + my_host + " <=> 'localhost' ");
  }
  puts("--------------------------------------------------------------------");
  test = "recup host-2";
  puts("test " + test);
  my_host = config.getCible('agoravox.appli');
  if (my_host === "10.75.202.100") {
    puts("" + test + " :OK");
  } else {
    puts("" + test + " :FAILED !!!!! => " + my_host + "  <=> '10.75.202.100'");
  }
}).call(this);
