angular.module('Burnup.controllers.Notifications', [])

.controller 'Notifications',

  ($scope, Notification, Auth) ->

    $scope.notificationsCount = 0
    $scope.notifications = null


    Auth.currentUser((currentUser) ->
      if currentUser and currentUser.id
        App.notifications = App.cable.subscriptions.create 'NotificationsChannel',
        received: (data) ->
          console.log data

        connected: ->
          # FIXME: While we wait for cable subscriptions to always be finalized before sending messages
          setTimeout =>
            console.log "subscribing to #{currentUser.id}"
            @perform 'notification_subscribed', user_id: currentUser.id
            , 1000
    )

    $scope.getNotifications = ->
      $scope.notifications = new Notification().all()

    $scope.getNotifications()



    return
