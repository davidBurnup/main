angular.module('Burnup.services.Auth', [])

.factory 'Auth', ($http) ->
  currentUserData = {}
  timeFormat = "DD/MM/YYYY HH:mm:ss"
  expirationLimit = 10
  @promise = null

  currentUser = ->
    if sessionStorage.getItem('currentUser')
      currentUserData = JSON.parse(unescape(sessionStorage.getItem('currentUser')))
    return currentUserData

  isSessionExpired = ->
    lastLoginTime = sessionStorage.getItem('lastLoginTime')
    isExpired = true
    if lastLoginTime and m = moment(lastLoginTime, timeFormat)
      if m and m.isValid() and m.isAfter(moment().subtract(expirationLimit, 'minutes'))
        isExpired = false

    return isExpired


  {
    currentUser: currentUser
  }
