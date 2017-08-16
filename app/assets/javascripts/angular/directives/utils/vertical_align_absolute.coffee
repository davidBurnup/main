angular.module('utils.buVerticalAlignAbsolute', [])

.directive 'buVerticalAlignAbsolute',  ->

  restrict: 'A'
  # templateUrl: 'churches/show.html'
  scope:
    offsetTop: "=?"

  controller: ($scope, $element, $window, $rootScope) ->

    $scope.offsetTop = 0 unless $scope.offsetTop
    
    behavior = ->
      elHeight = $element.outerHeight()
      $($element).css('position','absolute')
      $($element).css('top','50%')
      $($element).css('z-index','1')
      $($element).css('margin-top': "#{elHeight/2 * -1 + $scope.offsetTop}px")

    behavior()

    $scope.$on "verticalAlign:resize", ->
      console.log "resize"
      behavior()

    $(window).on 'resize', behavior
