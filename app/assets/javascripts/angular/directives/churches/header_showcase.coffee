angular.module('Burnup.directives.buHeaderShowCase', [])

.directive 'buHeaderShowCase',  (Church) ->

  restrict: 'EA'
  scope:
    churchId: '='
  templateUrl: 'churches/header_showcase.html'
  controller: ($scope, $rootScope, ngAudio) ->
    if $scope.churchId
      Church.get(id: $scope.churchId).then (church) ->
        $scope.church = church
        console.log "c", church
    # $scope.sound = ngAudio.load("/mon-coeur-est-a-toi.mp3")
    #
    # $scope.sound.play()
