angular.module('Burnup.controllers.UserTou', [])

.controller 'UserTou', ($scope, $timeout, $uibModalInstance, $rootScope) ->

  $scope.active = false

  # Make sure we show modal once this controller is loaded
  $timeout ->
    $scope.active = true

  $scope.closeModal = ->
    $uibModalInstance.close({status: false})

  $scope.resolveModal = ->
    $uibModalInstance.close({status: true})
  return
