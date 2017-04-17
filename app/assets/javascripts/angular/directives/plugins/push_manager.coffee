angular.module('Burnup.services.PushManager', [])

.factory 'PushManager', ($http, $q, $timeout, Auth, $rootScope, Browser) ->

  pushManagerObject = null

  setUserSession = (isEnabled) ->
    u = Auth.currentUser()
    u.webpushEnabled = isEnabled
    Auth.setSessionUserData(u)

  initialize = ->
    if navigator.serviceWorker and Auth.currentUser() and Browser.allowsWebPushNotifications()
      navigator.serviceWorker.ready.then (registration) ->
        pushManagerObject = registration.pushManager

        # Set webpushEnabled var according to current subscription
        registration.pushManager.getSubscription()
        .then (subscription) ->
          if subscription
            $timeout ->
              setUserSession(true)
          else
            $timeout ->
              setUserSession(false)

  unsubscribe = ->
    $q (resolve, reject) ->
      if pushManagerObject
        pushManagerObject.getSubscription()
        .then (subscription) ->
          console.log "log", subscription
          if subscription
            subscription.unsubscribe().then ->
              $http.post("/api/utilisateurs/#{Auth.currentUser().id}/push/unsubscribe",
                endpoint: subscription.endpoint
              ).then ->
                setUserSession(false)
                resolve()
              , (e) ->
                reject("Could not unsubscribe from server", e)

            .catch (e) ->
              console.warn "Could not unsubscribe", e
              reject("Could not unsubscribe", e)

          else
            reject("No subscription found !")
      else
        reject("No push manager object found !")

  subscribe = ->
    $q (resolve, reject) ->
      console.log "jjjj", pushManagerObject
      if pushManagerObject
        if u = Auth.currentUser()

          subscribeParams =
            userVisibleOnly: true

          if Browser.name() != "Chrome"
            # FIXME : Turn on VAPID authentification for all browsers
            # We disable VAPID for Chrome because it doesn't work for now with it
            # see - https://github.com/zaru/webpush/issues/25
            subscribeParams.applicationServerKey = window.vapidPublicKey

          console.log "log 2", pushManagerObject

          pushManagerObject.subscribe(subscribeParams)
          .then (subscription) ->
            if subscription
              $http.post("/api/utilisateurs/#{u.id}/push",
                subscription: subscription.toJSON(),
                vapid_enabled: (Browser.name() != "Chrome")
              ).then ->
                setUserSession(true)
                resolve(subscription)
              , (e) ->
                console.warn("Could send subscription to server !", e)
                reject("Could send subscription to server !", e)

            else
              reject("No subscription found !")

          .catch (e) ->
            console.warn('Registration denied !', e)
            reject("Registration denied !", e)
            return
        else
          reject("No current user found !")
      else
        reject("No push manager object found !")

  refreshSubscription = (callback) ->
    $q (resolve, reject) ->
      if pushManagerObject
        unsubscribe().then ->
          # Then resubscribe !
          subscribe().then (subscription) ->
            resolve(subscription)
          , (error_message, error_trace) ->
            reject(error_message, error_trace)

        , (error_message, error_trace) ->
          if error_message == "No subscription found !"
            subscribe().then (subscription) ->
              resolve(subscription)
            , (error_message, error_trace) ->
              reject(error_message, error_trace)
      else
        reject("No push manager object found !")

  {
    subscribe: subscribe
    refreshSubscription: refreshSubscription
    unsubscribe: unsubscribe
    initialize: initialize
  }
