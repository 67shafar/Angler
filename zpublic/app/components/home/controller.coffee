#Controls the homepage

HomeCtrl = ($scope, Page, $css) ->
  Page.setTitle "Home"
  $css.bind {href: '/assets/css/components/home/style.css'}, $scope
  return

HomeCtrl.$inject = ['$scope','Page', '$css']

angular
  .module('Angler')
  .controller('HomeCtrl', HomeCtrl)