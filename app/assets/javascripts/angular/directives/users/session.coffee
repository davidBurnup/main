angular.module('Burnup.directives.buUsersSession', [])

.directive 'buUsersSession', ($timeout, $rootScope, Auth) ->
  {
    restrict: 'A'
    scope:
      buUsersSession: "="

    controller: ($scope) ->
      $scope.setCurrentUser = (currentUserData) ->
        console.log "ud", currentUserData
        if currentUserData?
          Auth.setSessionUserData(currentUserData)
          $rootScope.currentUser = Auth.currentUser()

      $scope.setCurrentUser($scope.buUsersSession)
  }
