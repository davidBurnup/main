angular.module('Burnup.directives.buBootstrapFile', [])

.directive 'buBootstrapFile', (Notification, Auth, $timeout, $rootScope)->
  {
    restrict: 'EA'
    scope:
      buBootstrapFile: "=?"
    controller: ($scope, $element, $window, $timeout) ->

      $scope.buBootstrapFile = angular.extend {
        size: 'sm',
        input: false,
        iconName: 'glyphicon-camera',
        buttonText: 'Télécharger'
      }, $scope.buBootstrapFile

      $element.filestyle($scope.buBootstrapFile)
  }
