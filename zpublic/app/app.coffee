#Creates the AnglerCupOfJoeApp module
#Access it in other files with angular.module 'AnglerCupOfJoe'
#Coffeescript automatically wraps this in an IIFE

config = ($routeProvider)->
  $routeProvider
    .when '/' ,
      templateUrl: 'app/components/home/view.html'
      controller: 'HomeCtrl'

  return

config.$inject = ['$routeProvider']

MainCtrl = ($scope, Page)->
  $scope.page = Page
  return

MainCtrl.$inject = ['$scope', 'Page']

angular
  .module('Angler', ['ngRoute', 'door3.css'])
  .config(config)
  .controller('MainCtrl', MainCtrl)