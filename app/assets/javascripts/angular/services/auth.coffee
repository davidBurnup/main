angular.module('Burnup.services.Auth', [])

.factory 'Auth', ($http) ->
  currentUserData = {}
  timeFormat = "DD/MM/YYYY HH:mm:ss"
  expirationLimit = 10
  @promise = null

  currentUser = (callback) ->
    if sessionStorage.getItem('currentUser')
      currentUserData = JSON.parse(unescape(sessionStorage.getItem('currentUser')))
      callback(currentUserData)
    else
      if @promise
        @promise.then (successResponse) ->
          callback(successResponse.data)
    return currentUserData

  isSessionExpired = ->
    lastLoginTime = sessionStorage.getItem('lastLoginTime')
    isExpired = true
    if lastLoginTime and m = moment(lastLoginTime, timeFormat)
      if m and m.isValid() and m.isAfter(moment().subtract(expirationLimit, 'minutes'))
        isExpired = false

    return isExpired

  login = () ->
    if isSessionExpired()
      @promise = $http.get('/utilisateurs/en-cours.json')
      @promise.then (successResponse) ->
        currentUserData = successResponse.data
        sessionStorage.setItem('currentUser', escape(JSON.stringify(currentUserData)))
        sessionStorage.setItem('lastLoginTime', moment().format(timeFormat))
      , (errorResponse) ->
        console.warn errorResponse.data


  {
    currentUser: currentUser
    login: login
  }
