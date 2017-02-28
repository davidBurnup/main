angular.module('Burnup.controllers.ActivitiesLikersModal', [])

.controller 'ActivitiesLikersModal', ($scope, $timeout, $uibModalInstance, likers) ->
  $scope.likers = likers
