// javascript //
$(function() {
// modele pour un element
     window.UnElement   = Backbone.Model.extend({valeur: null});
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
// A la création de la vue, la  connexion du modele uneSuite avec cette vue
// est réalisée par passage de parametre 
window.UneSuiteView= Backbone.View.extend({
  el:  $('body'),
  events: {
      'click #add_element'              : 'addnumber',
           },  
    addnumber: function() {
      nouveau = new  UnElement({valeur: this.$('#new-element').val()});
      this.model.add(nouveau); 
    },

    initialize: function() {
      _.bindAll(this, 'addOne','render');
      this.model.bind('all', this.render);
      this.model.view = this;
      this.render();
      this.model.bind('add',     this.addOne);
   },
   addOne: function(UnElement) {
      var view = new ElementView({model: UnElement});//lien entre la vue et le modele UnElement
   //    var er =view.render().el;
      this.$("#suite").append(view.render().el);
      this.model.cumul += Number(UnElement.get('valeur'));
    },
// html de la vue pour les informations relatifs à la suite
   render:  function(){   
      $('#nombre_element').text(this.model.length);    
      $('#cumul_element').text(this.model.cumul);
      return this;
    }, 
});
// Vue relative à un nombre de la suite 
// Le lien entre la vue et un élément est réalisé dans addOne : 
  window.ElementView = Backbone.View.extend({
   tagName:'span',
   initialize: function() {
        _.bindAll(this, 'render');
         this.model.view = this;
    },      

  render: function() {
   $(this.el).append('=> ' +this.model.get("valeur"));
   $(this.el).attr('id',this.model.cid);
   return this;
    },
   });


// appel general , instanciation de la vue avec l'instance qui contient la suite des nombres  

  window.App = new UneSuiteView({model:masuite});
 
});

