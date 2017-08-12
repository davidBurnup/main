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
.directive 'focusMe', [
  '$timeout'
  '$parse'
  ($timeout, $parse) ->
    { link: (scope, element, attrs) ->
      model = $parse(attrs.focusMe)
      scope.$watch model, (value) ->
        if value == true
          $timeout ->
            element[0].focus()
            return
        return
      # to address @blesh's comment, set attribute value to 'false'
      # on blur event:
      element.bind 'blur', ->
        scope.$apply model.assign(scope, false)
        return
      return
 }
]
