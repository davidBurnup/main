angular.module('Burnup.controllers.UsersAccount', [])

.controller 'UsersAccount', ($scope, $timeout, $rootScope, $http, Auth, PushManager) ->

  $scope.togglingWebpush = false

  if Auth.currentUser()
    # Make a copy of the value to prevent the following $watch to create an infinite loop !
    $scope.webpushEnabled = angular.copy Auth.currentUser().webpushEnabled

  $scope.$watch "webpushEnabled", (webpushEnabled, webpushEnabledWas) ->
    # Lock one toggling at a time
    # And prevent first execution at initialization
    if !$scope.togglingWebpush and webpushEnabledWas? and webpushEnabled != webpushEnabledWas
      $scope.toggleWebpush(webpushEnabled)

  $scope.toggleWebpush = (webpushEnabled) ->
    if Auth.currentUser()
      $scope.togglingWebpush = true
      if !webpushEnabled
        PushManager.unsubscribe().then ->
          $scope.webpushEnabled = false
          $scope.togglingWebpush = false
        , ->
          $scope.togglingWebpush = false
      else
        PushManager.subscribe().then ->
          $scope.webpushEnabled = true
          $scope.togglingWebpush = false
        , ->
          $scope.togglingWebpush = false
