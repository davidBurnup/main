angular.module('Burnup.directives.notifications', [])

.directive 'notifications', (Notification, Auth, $timeout, $rootScope)->
  {
    restrict: 'A'
    templateUrl: 'notifications/notifications.html'
    scope:
      notification: "="
    controller: ($scope) ->
      $scope.notificationsCount = 0
      $scope.notifications = []
      $scope.ready = false
      $scope.notificationPage = 0
      $scope.lastPage = null
      $scope.status =
        isOpen: false


      Auth.currentUser((currentUser) ->
        if currentUser and currentUser.id
          App.notifications = App.cable.subscriptions.create 'NotificationsChannel',
          received: (notification) ->
            notification = JSON.parse(notification)

            $timeout ->
              $scope.notifications.splice(0, 0, notification)
              $scope.notificationsCount += 1
              console.log "new notifications", $scope.notifications

          connected: ->
            # FIXME: While we wait for cable subscriptions to always be finalized before sending messages
            setTimeout =>
              console.log "subscribing to #{currentUser.id}"
              @perform 'notification_subscribed', user_id: currentUser.id
              , 1000
      )

      $scope.getNotifications = (opts)->

        if opts and opts.nextPage
          $scope.notificationPage += 1

        if !$scope.lastPage or ($scope.lastPage and $scope.lastPage >= $scope.notificationPage)
          $scope.ready = false
          Notification.query(page: $scope.notificationPage)
          .then (notifications) ->
            $scope.notifications = $scope.notifications.concat(notifications)
            $scope.notificationsCount = notifications.$count
            $scope.lastPage = parseInt($scope.notificationsCount / 4)
            $scope.ready = true

      # $scope.$watch "notificationPage", (notificationPage) ->
      #   $scope.getNotifications()

      $scope.$watch "notifications", (notifications) ->
        $rootScope.notifications = notifications
        $scope.$broadcast "notifications", notifications

      $scope.$watch "status.isOpen", (isOpen) ->
        $rootScope.pageIsUnscrollable = isOpen
        console.log "isUn", isOpen
      # $scope.getNotifications()
  }
