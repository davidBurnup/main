angular.module('Burnup.directives.buChurchesShow', [])

.directive 'buChurchesShow', (User, SelectizeTemplator, $filter, Church) ->
  {
    restrict: 'E'
    templateUrl: 'churches/show.html'
    scope:
      church: "="

    controller: ($scope, $uibModal, $timeout, Auth, $rootScope) ->

      $scope.currentUser = Auth.currentUser()

      $scope.select = ->
        $scope.$emit "church:select", $scope.church

      $scope.unselect = ->
        $scope.$emit "church:unselect", $scope.church

      $rootScope.$on "currentUser:updated", (e, currentUser) ->
        $scope.currentUser = currentUser



  }
