@app = angular.module('Burnup', [

  # Angular Deps.
  "templates",

  # Models
  "Burnup.models.Notification",

  # Services
  "Burnup.services.Auth",

  # Directives
  "Burnup.directives.notification",

  # Controllers
  "Burnup.controllers.Main",
  "Burnup.controllers.Notifications"

])


@app.config(() ->
)

@app.run(($rootScope, Auth) ->
  @App = {}
  App.cable = Cable.createConsumer 'ws://127.0.0.1:28080'
  Auth.login()
)



$(document).on 'page:load', ->
  $('[ng-app]').each ->
    module = $(this).attr('ng-app')
    angular.bootstrap(this, [module])
