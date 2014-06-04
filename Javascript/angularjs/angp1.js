//------------------





//-----------------------

var mypayeApp = angular.module('payeApp', ['ngRoute']);
mypayeApp.directive('loading', function () {
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
  })

mypayeApp.config(['$routeProvider',
    function($routeProvider) {
     $routeProvider.
       when('/applications', {
         templateUrl: 'partials/application.html',
         controller: 'NoPaginationCtrl'
       }).
       when('/pgm', {
         templateUrl: 'partials/pgm.html',
         controller: 'PaginationCtrl'
       }).
        when('/jobs', {
         templateUrl: 'partials/job.html',
         controller: 'PaginationCtrl'
       }).
        when('/fetch', {
         templateUrl: 'partials/fetch.html',
         controller: 'PaginationCtrl'
       }).
        when('/step', {
         templateUrl: 'partials/step.html',
         controller: 'PaginationCtrl'
       }).
        when('/exec', {
         templateUrl: 'partials/exec.html',
         controller: 'PaginationCtrl'
       }).
        when('/file_part1', {
         templateUrl: 'partials/file.html',
         controller: 'PaginationCtrl'
       }).
             when('/file_part2', {
         templateUrl: 'partials/file.html',
         controller: 'PaginationCtrl'
       }).
        when('/file_part3', {
         templateUrl: 'partials/file.html',
         controller: 'PaginationCtrl'
       }).
        when('/file_part4', {
         templateUrl: 'partials/file.html',
         controller: 'PaginationCtrl'
       }).
        when('/file_part5', {
         templateUrl: 'partials/file.html',
         controller: 'PaginationCtrl'
       }).
        when('/file_part6', {
         templateUrl: 'partials/file.html',
         controller: 'PaginationCtrl'
       }).

       otherwise({
        redirectTo: '/'           
       });           
}]);


mypayeApp.filter('offset', function() {
  return function(input, start) {
    start = parseInt(start, 10);
    return input.slice(start);
  };
});

mypayeApp.factory('itemsFactoryBana', function($http){
    return {
        getItemsPgm: function() {
            return $http.get('/programmes/list');
            },
        getItemsJob: function() {
            return $http.get('/jobs/list');
            },
        getItemsFetch: function() {
            return $http.get('/fetch/list');
            },
        getItemsStep: function() {
            return $http.get('/step/list');
            },
        getItemsExec: function() {
            return $http.get('/exec/list');
            },
        getItemsF1: function() {
            return $http.get('/files/list/0');
            },
        getItemsF2: function() {
            return $http.get('/files/list/1');
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
            }
    };
});

mypayeApp.factory('itemsFactoryApp', function($http){
    return {
        getItems: function() {
            return $http.get('/applications/list');
        }
    };
});

mypayeApp.controller('NoPaginationCtrl', ['$scope','$location','itemsFactoryApp',
function($scope,$location,itemsFactoryApp)  {
 $scope.items = [];
  var handleSuccess = function(data, status) {
        $scope.items = data;
        $scope.my_size = $scope.items.length ;     
    };
  itemsFactoryApp.getItems().success(handleSuccess);
}]);


mypayeApp.controller('PaginationCtrl', ['$scope','$location','itemsFactoryBana',
function($scope,$location,itemsFactoryBana)  {
    $scope.itemsPerPage = 20;
    $scope.currentPage = 0;
    $scope.items = [];
    $scope.intervale = 0
var handleSuccess = function(data, status) {
        $scope.items = data;
       $scope.loading = false;
        $scope.my_size = $scope.items.length ;     
};
 if (/job/.test($location.path())) { 
     itemsFactoryBana.getItemsJob().success(handleSuccess);
 } 
 else if (/fetch/.test($location.path()))  {
   itemsFactoryBana.getItemsFetch().success(handleSuccess);}
 else if   (/step/.test($location.path()))  {
      $scope.loading = true;
   itemsFactoryBana.getItemsStep().success(handleSuccess);}    
 else if   (/exec/.test($location.path()))  {
      $scope.loading = true;
   itemsFactoryBana.getItemsExec().success(handleSuccess);}    
 else if (/pgm/.test($location.path())) {
      $scope.loading = true;
   itemsFactoryBana.getItemsPgm().success(handleSuccess);}     
 else if  (/part1/.test($location.path())) {
    $scope.loading = true;
    $scope.intervale = '0 - 6000'; 
   itemsFactoryBana.getItemsF1().success(handleSuccess);}     
 else if  (/part2/.test($location.path())) {
      $scope.loading = true;
       $scope.intervale = '6001 - 12000';
   itemsFactoryBana.getItemsF2().success(handleSuccess);}     
 else if  (/part3/.test($location.path())) {
      $scope.loading = true;
       $scope.intervale = '12001 - 18000';
   itemsFactoryBana.getItemsF3().success(handleSuccess);}     
 else if  (/part4/.test($location.path())) {
      $scope.loading = true;
       $scope.intervale = '18001 - 24000';
     itemsFactoryBana.getItemsF4().success(handleSuccess);}     
 else if  (/part5/.test($location.path())) {
      $scope.loading = true;
            $scope.intervale = '24001 - 30000';
   itemsFactoryBana.getItemsF5().success(handleSuccess);}     
 else if  (/part6/.test($location.path())) {
      $scope.loading = true;
            $scope.intervale = '30001 - Fin';
   itemsFactoryBana.getItemsF6().success(handleSuccess);}     

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
