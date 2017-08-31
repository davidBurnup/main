angular.module('Burnup.directives.buUsersShow', [])

.directive 'buUsersShow', (User, SelectizeTemplator, $filter, Page) ->
  {
    restrict: 'E'
    templateUrl: 'users/show.html'
    scope:
      userId: "="

    controller: ($scope, $uibModal, $timeout, User) ->

      User.get(id: $scope.userId).then (user) ->
        $scope.user = user




  }
