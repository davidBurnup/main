angular.module('Burnup.services.Auth', [])

.factory 'Auth', ($http, $rootScope, User) ->
  currentUserData = {}
  timeFormat = "DD/MM/YYYY HH:mm:ss"
  expirationLimit = 10
  @promise = null

  currentUser = (options) ->
    options = {} unless options
    if sessionStorage.getItem('currentUser')
      currentUserData = JSON.parse(unescape(sessionStorage.getItem('currentUser')))
      if options.camelize
        currentUserData = xcase.camelizeKeys(currentUserData)
    if options and options.getInstance
      return new User(currentUserData)
    else
      return currentUserData

  setCurrentUser = (user) ->
    sessionStorage.setItem('currentUser', escape(JSON.stringify(user)))
    $rootScope.$broadcast "currentUser:updated", currentUser()

  isSessionExpired = ->
    lastLoginTime = sessionStorage.getItem('lastLoginTime')
    isExpired = true
    if lastLoginTime and m = moment(lastLoginTime, timeFormat)
      if m and m.isValid() and m.isAfter(moment().subtract(expirationLimit, 'minutes'))
        isExpired = false

    return isExpired

  setSessionUserData = (data) ->
    if data?
      uData = angular.extend currentUser(), data
      sessionStorage.setItem('currentUser', escape(JSON.stringify(uData)))
      sessionStorage.setItem('lastLoginTime', moment().format(timeFormat))


  {
    currentUser: currentUser
    setCurrentUser: setCurrentUser
    setSessionUserData: setSessionUserData
  }
