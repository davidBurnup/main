angular.module('Burnup.directives.buHeaderShowCase', [])

.directive 'buHeaderShowCase',  ->

  restrict: 'EA'
  templateUrl: 'churches/header_showcase.html'
  scope:
    churchId: "="
  controller: ($scope, $rootScope, ngAudio, Church) ->
    Church.get(
      id: $scope.churchId
    ).then (church) ->
      $scope.lastActivityId = church.lastActivityId

    $scope.$on "activity:loaded", (e, activity) ->
      $scope.$broadcast "verticalAlign:resize"

    $scope.$on "audio:loaded", (e, activity) ->
      $scope.$broadcast "verticalAlign:resize"

    $scope.slideDown = ->
      $('html, body').animate({
    	   scrollTop: $("#feed-activities").offset().top
    	}, 'slow')
