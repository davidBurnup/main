angular.module('Burnup.directives.buPagesHeaderShowCase', [])

.directive 'buPagesHeaderShowCase',  (Page, $sce) ->

  restrict: 'EA'
  scope:
    pageId: '='
  templateUrl: 'pages/header_showcase.html'
  controller: ($scope, $rootScope, ngAudio, Auth) ->

    $scope.infoModalOn = false

    $scope.currentUser = Auth.currentUser()

    if $scope.pageId
      Page.get(id: $scope.pageId).then (page) ->
        $scope.page = page
        if page.youtubeVideoId?
          $scope.youtubeUrl = $sce.trustAsResourceUrl("http://www.youtube.com/embed/#{page.youtubeVideoId}")

    $scope.goDown = ->
      $scope.infoModalOn = false
      n = $(window).height()
      $('html, body').animate { scrollTop: n }, 1000

    $scope.goUp = ->
      n = $(window).height()
      $('html, body').animate { scrollTop: 0 }, 1000

    $scope.toggleInfo = ->
      $scope.infoModalOn = !$scope.infoModalOn

    $rootScope.$on "pagesHeaderShowCase:showInfo", ->
      $scope.goUp()
      $scope.infoModalOn = true


    # $scope.sound = ngAudio.load("/mon-coeur-est-a-toi.mp3")
    #
    # $scope.sound.play()
