angular.module('Burnup.controllers.UsersLogin', [])

.controller 'UsersLogin', ($scope, $timeout, $uibModalInstance, $rootScope, $http) ->

  $scope.active = false
  $scope.user =
    email: ""
    password: ""
    remember_me: true

  # Make sure we show modal once this controller is loaded
  $timeout ->
    $scope.active = true

  $scope.closeModal = ->
    $uibModalInstance.close({status: false})

  $scope.login = ->
    if $scope.user.email? and $scope.user.password?
      $scope.loading = true
      $scope.unauthorized = false
      $http.post "/api/sessions/se-connecter.json",
        user: $scope.user
      .then (r) ->
        # $scope.loading = false
        window.location.reload()
      , (e) ->
        console.log "error", e
        $scope.loading = false
        if e.status == 401
          $scope.unauthorized = true





  return
