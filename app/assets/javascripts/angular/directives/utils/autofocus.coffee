angular.module('utils.autofocus', [])
.directive 'autofocus', [
  '$timeout'
  ($timeout) ->
    {
      restrict: 'A'
      link: ($scope, $element) ->
        console.log "kkk", $element
        $timeout ->
          $element[0].focus()
          return
        return

    }
]
