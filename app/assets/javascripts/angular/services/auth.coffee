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
      u = new User(currentUserData)
    else
      u = currentUserData

    if Object.keys(u).length > 0
      return u
    else
      return

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

  isLoggedIn = ->
    return currentUser() and currentUser().id?


  {
    currentUser: currentUser
    setCurrentUser: setCurrentUser
    setSessionUserData: setSessionUserData
    isLoggedIn: isLoggedIn
  }
