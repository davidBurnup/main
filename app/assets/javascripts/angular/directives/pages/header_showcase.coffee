angular.module('Burnup.directives.buHeaderShowCase', [])

.directive 'buHeaderShowCase',  (Page) ->

  restrict: 'EA'
  scope:
    pageId: '='
  templateUrl: 'pages/header_showcase.html'
  controller: ($scope, $rootScope, ngAudio) ->
    if $scope.pageId
      Page.get(id: $scope.pageId).then (page) ->
        $scope.page = page
        console.log "c", page

    $scope.goDown = ->
      n = $(window).height()
      $('html, body').animate { scrollTop: n }, 1000

    # $scope.sound = ngAudio.load("/mon-coeur-est-a-toi.mp3")
    #
    # $scope.sound.play()
