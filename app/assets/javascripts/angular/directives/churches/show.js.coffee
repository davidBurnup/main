angular.module('Burnup.directives.buChurchesShow', [])

.directive 'buChurchesShow', (User, SelectizeTemplator, $filter, Church) ->
  {
    restrict: 'E'
    templateUrl: 'churches/show.html'
    scope:
      church: "="

    controller: ($scope, $uibModal, $timeout) ->

      $scope.select = ->
        $scope.$emit "church:select", $scope.church




  }
