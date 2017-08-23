angular.module('Burnup.directives.buUsersNew', [])

.directive 'buUsersNew', (User, SelectizeTemplator, $filter, Page) ->
  {
    restrict: 'E'
    templateUrl: 'users/new.html'
    scope:
      user: "="

    controller: ($scope, $uibModal, $timeout) ->

      $scope.user = {} unless $scope.user
      $scope.submitting = false
      $scope.submitted = false
      $scope.errors = {}
      touLock = false

      $scope.submit = ->

        $scope.submitting = true

        new User($scope.user).save().then (data) ->
          if data.errors
            $scope.errors = data.errors
          else
            $scope.submitted = true

          $scope.submitting = false

        , (errors) ->
          $scope.submitting = false

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
