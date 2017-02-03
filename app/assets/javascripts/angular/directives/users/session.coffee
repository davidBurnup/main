angular.module('Burnup.directives.buUsersSession', [])

.directive 'buUsersSession', ($timeout, $rootScope, Auth) ->
  {
    restrict: 'A'
    scope:
      amSessionData: "="

    controller: ($scope) ->

      $scope.setCurrentUser = (currentUserData) ->
        if currentUserData?
          Auth.setSessionUserData(currentUserData)
          $rootScope.currentUser = Auth.currentUser()

      $scope.setCurrentUser($scope.amSessionData)
  }
