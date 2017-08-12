angular.module('utils.buAdaptWindow', [])

.directive 'buAdaptWindow',  ->

  restrict: 'A'
  # templateUrl: 'churches/show.html'
  scope:
    direction: "="

  controller: ($scope, $element, $window, $rootScope) ->

    sizingBehavior = ->
      windowHeight = $($window).outerHeight()
      $rootScope.windowHeight = windowHeight
      $element.height(windowHeight)
    sizingBehavior()
    $(window).on 'resize', sizingBehavior

    scrollBehavior = ->
      scrollPosition = $(window).scrollTop()
      maxPosition = $(window).outerHeight()
      minBackgroundYPosition = 35 # in %
      maxBackgroundYPosition = 65 # in %

      # Compute Scroll in percentage of the header height
      scrollPercentage = scrollPosition / maxPosition

      scrollPosition = scrollPercentage * (maxBackgroundYPosition - minBackgroundYPosition) + minBackgroundYPosition

      if scrollPosition > maxBackgroundYPosition
        scrollPosition = maxBackgroundYPosition

      # scrollPosition = Math.floor(scrollPosition)

      # Apply the background position
      $($element).find('.background-image').css 'background-position-y', "#{scrollPosition}%"
    scrollBehavior()
    $(document).on 'scroll', scrollBehavior
