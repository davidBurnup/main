angular.module('utils.Browser', [])

.provider 'BrowserRowInfo', ->
  @.$get = [->
    ua = navigator.userAgent
    tem = undefined
    M = ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*(\d+)/i) or []
    if /trident/i.test(M[1])
      tem = /\brv[ :]+(\d+)/g.exec(ua) or []
      return {
        name: 'IE'
        version: tem[1] or ''
      }
    if M[1] == 'Chrome'
      tem = ua.match(/\bOPR\/(\d+)/)
      if tem != null
        return {
          name: 'Opera'
          version: tem[1]
        }
    M = if M[2] then [
      M[1]
      M[2]
    ] else [
      navigator.appName
      navigator.appVersion
      '-?'
    ]
    if (tem = ua.match(/version\/(\d+)/i)) != null
      M.splice 1, 1, tem[1]

    # Return Browser raw info
    {
      name: M[0]
      version: M[1]
    }
  ]
  return

.factory 'Browser', (BrowserRowInfo)->

  name = ->
    i = BrowserRowInfo.name

  version = ->
    i = BrowserRowInfo.version

  allowsWebPushNotifications = ->
    name() in ["Chrome", "Firefox"]


  return {
    name: name
    version: version
    allowsWebPushNotifications: allowsWebPushNotifications
  }
