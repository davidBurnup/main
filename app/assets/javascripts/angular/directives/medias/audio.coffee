angular.module('Burnup.directives.buMediasAudio', [])

.directive 'buMediasAudio', (Activity, $sce, Auth, User, $timeout, $uibModal, $http) ->
  {
    restrict: 'AE'
    templateUrl: 'medias/audio.html'
    scope:
      media: "="

    controller: ($scope, Auth, $timeout, Comment, ngAudio) ->
      $scope.audioIsPlaying = false
      $scope.audioProgressPerCent = 0
      $scope.audioProgressChanging = false

      if $scope.media and $scope.media.attachment and $scope.media.attachment.url
        $scope.audio = ngAudio.load($scope.media.attachment.url)


      $scope.togglePlay = ->
        console.log "audio", $scope.audio, $scope.audio.currentTime
        if $scope.audio.paused
          $scope.audio.play()
        else
          $scope.audio.pause()

  }
