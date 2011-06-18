// javascript //
$(function() {
// modele pour un element
// Un element ne comporte qu'un attribut sa valeur

     window.UnElement   = Backbone.Model.extend({valeur: null});

// modele pour la suite des elements
// Définition d'une collection d'element de la suite.
// On ajoute un attribut cumul à cette collection
// l'attribut 'model' fait le lien entre le modele d'un element
// et le modele de la collection

     window.UneSuite = Backbone.Collection.extend({
        model: UnElement,
        initialize: function(models, options) {
        this.cumul= 0;
        },
     });
// Instanciation de la collection 
   masuite= new  UneSuite;

// mise en place de la vue pour UneSuite
// A la création de la vue, la  connexion du modele (collection) uneSuite avec cette vue
// est réalisée par passage de parametre au moment de l'appel.
// La vue encapsule des evenements navigateurs mais aussi des evenements sur les modèles (ajout d un élément) , des handlers d'evenements et des portions d'ecran (render) 
// l'attribut 'el' indique sur quel type d'element du DOM on accroche la vue. 
// Cette notion est importante pour l'interception des evenements navigateur :click
  window.UneSuiteView= Backbone.View.extend({
    el:  $('body'),
    events: {
      'click #add_element'               : 'addnumber',
      'click #supp_element'              : 'deletelast',
           },  
// addnumber et deletelast sont les callback qui sont appellés sur les clics 
    deletelast: function() {
       var killme= this.model.last();
       this.model.remove(killme);
// Le remove de l'element de la collection déclenche un evement 'remove' qui est lié à un callback  
           },  
    addnumber: function() {
      nouveau = new  UnElement({valeur: this.$('#new-element').val()});
      this.model.add(nouveau); 
// Le add de l'element de la collection déclenche un evement 'add' qui est lié à un callback  

    },

    initialize: function() {
      _.bindAll(this,'removeOne', 'addOne','render');
      this.model.bind('all', this.render);
      this.model.view = this;
      this.render();
      this.model.bind('add',     this.addOne);
      this.model.bind('remove',     this.removeOne);

   },
   addOne: function(UnElement) {
//lien entre la vue de la collection et la vue du  modele UnElement
      var view = new ElementView({model: UnElement});
//      this.$("#suite").append(view.render().el);
//      cette notation doit se lire comme ceci $(selecteur,this.el) 
       $("#suite").append(view.render().el);
//view.render().el retourne une span (el)  identifiée par le numero de l'élément (cid) 
      this.model.cumul += Number(UnElement.get('valeur'));
    },
    removeOne: function(UnElement) {
       var tmp= "#" +UnElement.cid;
       this.model.cumul -= Number(UnElement.get('valeur'));
       $(tmp).remove();
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


// appel general , instanciation de la vue avec l'objet  qui contient la suite des nombres(collection)   

  window.App = new UneSuiteView({model:masuite});
 
});

