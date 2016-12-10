@app = angular.module('Burnup', [

  # Angular Deps.
  "templates"
  "angularMoment"
  "ui.bootstrap"
  "infinite-scroll"

  # Models
  "Burnup.models.Notification"

  # Services
  "Burnup.services.Auth"

  # Directives
  "Burnup.directives.notifications"

  # Controllers
  "Burnup.controllers.Main"

])


@app.config(() ->
)

@app.run(($rootScope, Auth, amMoment) ->
  @App = {}
  App.cable = Cable.createConsumer 'ws://127.0.0.1:28080'
  Auth.login()
  amMoment.changeLocale('fr')
)



$(document).on 'page:load', ->
  $('[ng-app]').each ->
    module = $(this).attr('ng-app')
    angular.bootstrap(this, [module])
