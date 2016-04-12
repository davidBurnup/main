angular.module('Burnup.directives.notification', [])

.directive 'notification', ->
  {
    restrict: 'E'
    templateUrl: 'notifications/notification.html',
    scope: {
      notification: "="
    }
  }
