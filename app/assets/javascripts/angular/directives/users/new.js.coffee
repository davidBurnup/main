angular.module('Burnup.directives.buUsersNew', [])

.directive 'buUsersNew', ->
  {
    restrict: 'E'
    templateUrl: 'users/new.html'
    scope:
      user: "="

    controller: ($scope, $uibModal, $timeout) ->

      $scope.user = {} unless $scope.user
      touLock = false

      $scope.submit = ->
        console.log "submit now !"

      $scope.$watch "user.tou", (tou) ->
        if tou and !touLock
          touLock = true
          modalInstance = $uibModal.open(
            templateUrl: 'users/tou.html'
            controller: 'UserTou'
            size: 'md'
            backdrop: 'static'
            # resolve:
            #   feedRecipientType: ->
            #     $scope.feedRecipientType
            #   feedRecipientId: ->
            #     $scope.feedRecipientId
          )

          modalInstance.result.then (p) ->
            $scope.user.tou = p.status
            $timeout ->
              touLock = false

          $scope.user.tou = false

  }
