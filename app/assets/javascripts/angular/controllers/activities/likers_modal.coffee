angular.module('Burnup.controllers.ActivitiesLikersModal', [])

.controller 'ActivitiesLikersModal', ($scope, $timeout, $uibModalInstance, likers) ->
  $scope.likers = likers

  $scope.close = ->
    $uibModalInstance.close()

  $timeout ->
    $scope.active = true
