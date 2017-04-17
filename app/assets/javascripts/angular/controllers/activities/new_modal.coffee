angular.module('Burnup.controllers.ActivitiesNewModal', [])

.controller 'ActivitiesNewModal', ($scope, $timeout, $uibModalInstance, withPhoto, Auth, Post) ->

  $scope.withPhoto = withPhoto
  $scope.currentUser = Auth.currentUser(camelize: true)
  $scope.post = new Post(
   content: ""
  )

  $('.modal-backdrop').addClass('visible')

  $scope.close = ->
    if !$scope.savingPost
      $('.modal-backdrop').removeClass('visible')
      $uibModalInstance.close()

  $scope.save = ($event) ->
    $event.preventDefault()
    $scope.savingPost = true
    $scope.post.save()
    .then (activity) ->
      $scope.savingPost = false
      $('.modal-backdrop').removeClass('visible')
      $uibModalInstance.close(activity)



  $timeout ->
    $scope.active = true
