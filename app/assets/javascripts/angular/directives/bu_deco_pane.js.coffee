angular.module('Burnup.directives.buDecoPane', [])

.directive 'buDecoPane', (Notification, Auth, $timeout, $rootScope)->
  {
    restrict: 'E'
    templateUrl: 'shared/bu_deco_pane.html'
    scope:
      image: "@"
    controller: ($scope, $element, $window, $timeout) ->

      rightColumn = $("#right-column")
      $element.css('background-image', "url('#{$scope.image}')")

      $scope.sizing = ->
        $element.height($($window).height() - 80)
        $element.width($(rightColumn).width())

      $timeout ->
        $scope.sizing()
        $element.addClass('active')

      $($window).resize($scope.sizing)
  }
