var app = angular.module('AppBanHang', []);
app.controller("HomeCtrl", function ($scope, $http) {
    $http.get('https://localhost:7295/get-top-view-sanpham?limit=10')
    .then(function(response) {
        $scope.myWelcome = response.data;
        console.log(response.data)
      });
});