angular.module('Burnup.directives.buHeaderShowCase', [])

.directive 'buHeaderShowCase',  ->

  restrict: 'EA'
  templateUrl: 'churches/header_showcase.html'
  controller: ($scope, $rootScope, ngAudio) ->
    # $scope.sound = ngAudio.load("/mon-coeur-est-a-toi.mp3")
    #
    # $scope.sound.play()
