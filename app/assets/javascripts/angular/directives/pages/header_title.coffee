angular.module('Burnup.directives.buPagesHeaderTitle', [])

.directive 'buPagesHeaderTitle',  (Page, $sce) ->

  restrict: 'EA'
  scope:
    pageId: '='
    subTitle: '=?'
  templateUrl: 'pages/header_title.html'
  controller: ($scope, $rootScope, ngAudio, Auth) ->

    $scope.currentUser = Auth.currentUser()

    if $scope.pageId
      Page.get(id: $scope.pageId).then (page) ->
        $scope.page = page

    $scope.toggleFollow = ->
      $scope.isFollowing = true
      $scope.page.toggleFollow().then ->
        $scope.isFollowing = false

    $scope.showInfo = ->
    	$rootScope.$broadcast "pagesHeaderShowCase:showInfo"