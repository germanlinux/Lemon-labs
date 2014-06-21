var myApplModule = angular.module('myAppli',[]);
                                              
myApplModule.controller('HelloController',['$scope',
function($scope) {
$scope.greeting = { text: 'Hello' };
}]);
