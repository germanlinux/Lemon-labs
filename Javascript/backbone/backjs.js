// javascript //
//var jQuery ="leurre";
$(function() {
// modele pour un element
     window.UnElement = Backbone.Model.extend({valeur: null});
     window.ElementView = Backbone.View
// modele pour la suite des elements
       window.UneSuite = Backbone.Collection.extend({
       model: UnElement,
    initialize: function(models, options) {
        this.cumul= 0;
    },
      });
       // lien entre les deux modeles
       masuite= new  UneSuite;
// mise en place de la vue pour UneSuite
window.UneSuiteView= Backbone.View.extend({
  el:  $('body'),
  events: {
      'click #add_element'              : 'addnumber',
           },  
    addnumber: function() {
    nouveau = new  UnElement({valeur: this.$('#new-element').val()});
     this.model.add(nouveau); 
 //   alert("je passe");
    },

// a la création de la vue, connecter le modele uneSuite avec cette vue.
    initialize: function() {
      _.bindAll(this, 'addOne','render');
      this.model.bind('all', this.render);
      this.model.view = this;
      this.render();
      this.model.bind('add',     this.addOne);

    },
     addOne: function(UnElement) {
    //  this.model.create(UnElement); 
      var view = new ElementView({model: UnElement});
      this.$("#suite").append(view.render().el);
      this.model.cumul += Number(UnElement.get('valeur'));
      this.render();
    },
    render:  function(){   
        $('#nombre_element').text(this.model.length);    
        $('#cumul_element').text(this.model.cumul);
        
       },
  

});
  window.ElementView = Backbone.View.extend({
        initialize: function() {
        _.bindAll(this, 'render');
      this.model.bind('add', this.render);
      this.model.view = this;
    },      

  render: function() {
      $('#suite').append(' ' +this.model.get("valeur"));
      return this;
    },
   });


  //test une vue 

  window.App = new UneSuiteView({model:masuite});
 /*  var a= new UnElement({valeur:5});
    masuite.add(a);
 a= new UnElement({valeur:2});

   masuite.add(a);
 a= new UnElement({valeur:6});

    masuite.add(a);
*/
 // fin generale 

});
       /* essai divers       

   var a= new UnElement({valeur:1});
    masuite.add(a);
    var b= new UnElement({valeur:2});
    masuite.add(b,{silent:true});
    var e="eric";
    masuite.bind("add", function(v) {
    alert("Ahoy " + v.get("valeur") + "!");
    });
*/

  
/*
         update_suite_total: function(){
                                      $("#nombre_element").html(this.length);
        },
       initialize: function(models, options) {
                                      $("#nombre_element").html(this.length);
                                      this.bind("add", options.view.add_nombre);
                                      this.bind("add", this.update_suite_total);
        }      
      });
  */

//});
/*
UneSuite = Backbone.Collection.extend({
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
  var appview= new AppView;
*/
//});
