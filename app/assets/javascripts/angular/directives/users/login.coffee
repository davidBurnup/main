angular.module('Burnup.directives.buUsersLogin', [])

.directive 'buUsersLogin', (User, SelectizeTemplator, $filter, Church) ->
  {
    restrict: 'A'
    controller: ($scope, $uibModal, $timeout, $element) ->

      $element.on "click", ->
        modalInstance = $uibModal.open(
          templateUrl: 'users/login.html'
          controller: 'UsersLogin'
          size: 'sm'
          backdrop: 'static'
          # resolve:
          #   feedRecipientType: ->
          #     $scope.feedRecipientType
          #   feedRecipientId: ->
          #     $scope.feedRecipientId
        )

      # modalInstance.result.then (p) ->
      #


  }
