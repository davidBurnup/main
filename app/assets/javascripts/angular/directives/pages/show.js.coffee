angular.module('Burnup.directives.buPagesShow', [])

.directive 'buPagesShow', (User, SelectizeTemplator, $filter, Page) ->
  {
    restrict: 'E'
    templateUrl: 'pages/show.html'
    scope:
      page: "="

    controller: ($scope, $uibModal, $timeout, Auth, $rootScope) ->

      $scope.currentUser = Auth.currentUser()

      $scope.select = ->
        $scope.$emit "page:select", $scope.page

      $scope.unselect = ->
        $scope.$emit "page:unselect", $scope.page

      $rootScope.$on "currentUser:updated", (e, currentUser) ->
        $scope.currentUser = currentUser



  }
