
//-----------------------

var myApp = angular.module('mongoApp', ['ngRoute','ngSanitize']);
myApp.directive('loading', function () {
      return {
        restrict: 'E',
        replace:true,
        template: '<div class="loading"><img src="/images/loading.gif" />LOADING...</div>',
        link: function (scope, element, attr) {
              scope.$watch('loading', function (val) {
                  if (val)
                      $(element).show();
                  else
                      $(element).hide();
              });
        }
      }
  });


myApp.config(['$routeProvider',
    function($routeProvider) {
     $routeProvider.
       when('/programmes_batch', {
         templateUrl: 'partials/pgm.html',
         controller: 'PaginationCtrl'
       }).
       when('/TPR', {
         templateUrl: 'partials/tpr.html',
         controller: 'PaginationCtrl'
       }).
       when('/jcl', {
         templateUrl: 'partials/jcl.html',
         controller: 'PaginationCtrl'
       }).
       when('/j_source/:jcl', {
         templateUrl: 'partials/j_source.html', 
         controller: 'SourceCtrl'        
       }).
        otherwise({
          redirectTo: '/'           
       });           
}]);

myApp.filter('retourligne', function() {
      return function(input) {
        input = input || '';
        out = input.replace(/\n/g, '<br>');
        return out;
      };
});

myApp.filter('offset', function() {
  return function(input, start) {
    start = parseInt(start, 10);
    return input.slice(start);
  };
});

myApp.factory('itemsFactoryBana',
    function($http){
    return {
        getItemsPgm: function() {
            return $http.get('/programmes/list');
            },
        getItemsJob: function() {
            return $http.get('/jobs/list');
            },
        getItemsFetch: function() {
            return $http.get('/fetchs/list');
            },
        getItemsStep: function() {
            return $http.get('/steps/list');
            },
        getItemsExec: function() {
            return $http.get('/execs/list');
            },
        getItemsTPR: function() {
            return $http.get('/TPR/list');
            },
        getItemsJCL: function() {
            return $http.get('/jcl/list');
            },
        getItemsF3: function() {
            return $http.get('/files/list/2');
            },
        getItemsF4: function() {
            return $http.get('/files/list/3');
            },
        getItemsF5: function() {
            return $http.get('/files/list/4');
            },
        getItemsF6: function() {
            return $http.get('/files/list/5');
            },
        getItemsFS: function(likeme) {
            return $http.get('/files/like/' + likeme);
            
            }
    };
});

myApp.factory('itemsFactoryApp', function($http){
    return {
        getItems: function() {
            return $http.get('/applications/list');
        }
    };
});
myApp.factory('uneItemFactory', function($http){
    return {
        getItem: function(le_jcl) {
            return $http.get('/j_source/' + le_jcl);
        }
    };
});

myApp.controller('SourceCtrl',['$scope','$routeParams','uneItemFactory',
    function($scope,$routeParams,uneItemFactory)  {
         $scope.item ={}

        var handleSuccess = function(data, status) {
        $scope.item = data;
       // console.log(data) ;
        $scope.my_size = $scope.item.length ;   
        console.log($scope.item)  
    };
  uneItemFactory.getItem($routeParams.jcl).success(handleSuccess);
 }]);            

myApp.controller('NoPaginationCtrl', ['$scope','$location','itemsFactoryApp',
function($scope,$location,itemsFactoryApp)  {
 $scope.items = [];

  var handleSuccess = function(data, status) {
        $scope.items = data;
        console.log(data) ;
        $scope.my_size = $scope.items.length ;     
    };
  itemsFactoryApp.getItems().success(handleSuccess);
}]);
 myApp.controller('SimpleCtrl', ['$scope','uneItemFactory',
   function($scope,uneItemFactory)  {
   $scope.un_jcl =''
 var handleSuccess = function(data, status) {
        $scope.un_jcl = data;
        console.log(data) ;
    };
  uneItemFactory.getItem().success(handleSuccess);

}]);

                                    
myApp.controller('PaginationCtrl', ['$scope','$location','itemsFactoryBana',    
function($scope,$location,itemsFactoryBana)  {
    $scope.itemsPerPage = 20;
    $scope.currentPage = 0;
    $scope.monfiltre = "";
    $scope.items = [];
    $scope.pardate = false;
    $scope.reverse = 0;
    $scope.ctri= 'programme'; 
    $scope.intervale = 0;
    $scope.submit = function() {
      if ($scope.monfiltre) {
         itemsFactoryBana.getItemsFS(this.monfiltre).success(handleSuccess);          
        console.log(this.monfiltre);
      }
    };
    $scope.changetri = function(){
        if ($scope.pardate)  {
          $scope.ctri    = 'epoc'; 
          $scope.reverse = true;
        } 
        else {
          $scope.ctri    = 'programme'; 
          $scope.reverse = false;
        } 
     };  
var handleSuccess = function(data, status) {
        $scope.items = data;
       $scope.loading = false;
        $scope.my_size = $scope.items.length ;     
};
 if (/job/.test($location.path())) { 
     itemsFactoryBana.getItemsJob().success(handleSuccess);
 } 
     else if (/programmes_batch/.test($location.path())) {
      $scope.loading = true;
   itemsFactoryBana.getItemsPgm().success(handleSuccess);}     
     else if (/TPR/.test($location.path())) {
      $scope.loading = true;
   itemsFactoryBana.getItemsTPR().success(handleSuccess);}     
     else if (/jcl/.test($location.path())) {
      $scope.loading = true;
   itemsFactoryBana.getItemsJCL().success(handleSuccess);}     
        

    $scope.range = function() {
    var rangeSize = 5;
    var ret = [];
    var start;

    start = $scope.currentPage;
    if ( start > $scope.pageCount()-rangeSize ) {
      start = $scope.pageCount()-rangeSize+1;
    }

    for (var i=start; i<start+rangeSize; i++) {
      ret.push(i);
    }
    return ret;
  };

  $scope.prevPage = function() {
    if ($scope.currentPage > 0) {
      $scope.currentPage--;
    }
  };

  $scope.prevPageDisabled = function() {
    return $scope.currentPage === 0 ? "disabled" : "";
  };

  $scope.pageCount = function() {
    return Math.ceil($scope.items.length/$scope.itemsPerPage)-1;
  };

  $scope.nextPage = function() {
    if ($scope.currentPage < $scope.pageCount()) {
      $scope.currentPage++;
    }
  };

  $scope.nextPageDisabled = function() {
    return $scope.currentPage === $scope.pageCount() ? "disabled" : "";
  };

  $scope.setPage = function(n) {
    $scope.currentPage = n;
  };     
        
}]);
