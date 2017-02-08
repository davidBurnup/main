angular.module('Burnup.directives.buUsersLogin', [])

.directive 'buUsersLogin', (User, SelectizeTemplator, $filter, Church) ->
  {
    restrict: 'A'
    controller: ($scope, $uibModal, $timeout, $element, $window) ->

      $scope.showSessionModal = ->
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

      $element.on "click", ->
        $scope.showSessionModal()

      if $window.location.href.match("/utilisateurs/se-connecter")?
        $scope.showSessionModal()
        
      # modalInstance.result.then (p) ->
      #


  }
