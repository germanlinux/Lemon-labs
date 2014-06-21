var myApplModule = angular.module('myAppli',['ngRoute']);

myApplModule.config(['$routeProvider',
    function($routeProvider) {
     $routeProvider.
       when('/page1', {
         templateUrl: 'partials/page1.tpl.html'
       }).
       when('/page2', {
         templateUrl: 'partials/page2.tpl.html'
       }).
       otherwise({
        templateUrl: 'partials/pageD.tpl.html',
        redirectTo: '/'           
       });           
}]);
myApplModule.controller('HelloController',['$scope',
function($scope) {
$scope.greeting = { text: 'Hello' };
}]);

