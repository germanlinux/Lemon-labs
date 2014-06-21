describe("Controller Test", function () {
 
// Arrange
var mockScope = {};
var controller;
 
beforeEach(angular.mock.module("myAppli"));
 
beforeEach(angular.mock.inject(function ($controller, $rootScope) {
mockScope = $rootScope.$new();
controller = $controller("HelloController", {
$scope: mockScope
});
}));
 
// Act and Assess
it("Creates variable", function () {
expect(mockScope.greeting.text).toBe("Hello");
})
});
