angular.module('Burnup.directives.buUsersLogin', [])

.directive 'buUsersLogin', (User, SelectizeTemplator, $filter, Page) ->
  {
    restrict: 'A'
    controller: ($scope, $uibModal, $timeout, $element, $window, $rootScope) ->

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

      if $window.location.hash == "#sign-up" and !$rootScope.sessionModalOpened
        $scope.autoOpen = true
        $rootScope.sessionModalOpened = true

      if $scope.autoOpen
        $('html, body').animate { scrollTop: n }, 1000
      # modalInstance.result.then (p) ->
      #


  }
