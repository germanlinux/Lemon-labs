<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
  
  <meta content="text/html; charset=ISO-8859-1" http-equiv="content-type">
  <title>back1</title>
<script src="jquery.min.js" type="text/javascript"></script>
<script src="backbone.js" type="text/javascript"></script>
<script src="underscore.js" type="text/javascript"></script>  
</head>  

<body>
<h1> suite de nombre </h1>
<input type="text" name="nombre" id="new-element"/> 
<input type="button" id="#add_element" /> 
<p>
nombre total: <span id="nombre_element" ></span>
</p>
<div id="suite"></div>

<script  type="text/javascript">
// javascript //
//var jQuery ="leurre";
(function ($) {

UnElement = Backbone.Model.extend({
//  rang: null,
  valeur: null
});

UneSuite = Backbone.collection.extend({
  update_suite_total: function(){
    $("#nombre_element").html(this.length);
   },
  initialize: function(models, options) {
    $("#nombre_element").html(this.length);
    this.bind("add", options.view.add_nombre);
    this.bind("add", this.update_suite_total);
 
  }      
});
AppView = Backbone.View.extend({
  el: $("body"),
  initialize: function() {
       this.unesuite = new UneSuite(null,{view:this} );
    },
  events: { 
        "click #add_element" : "add_element" 
   },
  add_element: function() {
    var nb = $("#new-element").val();
    this.unesuite.add({valeur : nb});
  },
   add_nombre: function(model) {
      $("suite").append("<br>" + model.get(nb)+"</br>");            
   }
});    
  var appview= new Appview;
})(jQuery);
</script>
</body>
</html>
