var app = angular.module("MyApp", []);

app.filter('offset', function() {
  return function(input, start) {
    start = parseInt(start, 10);
    return input.slice(start);
  };
});

app.factory('itemsFactory', function($http){
    return {
        getItems: function() {
            return $http.get('/programmes/list');
        }
    };
});

app.factory('itemsFactorypgm', function($http){
    return {
        getItems: function() {
            return $http.get('/programmes/list');
        }
    };
});




app.controller("PaginationCtrl", function($scope,itemsFactorypgm) {
 
  $scope.itemsPerPage = 20;
  $scope.currentPage = 0;
  $scope.items = [];

  var handleSuccess = function(data, status) {
        $scope.items = data;
        $scope.my_size = $scope.items.length ;     
    };


  itemsFactorypgm.getItems().success(handleSuccess);
  
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

});



app.controller("HelloController",function($scope) {
$scope.greeting = { text: 'Hello' };
}
);
