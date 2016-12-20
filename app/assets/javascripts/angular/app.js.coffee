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
  "Burnup.directives.buDecoPane"

  # Controllers
  "Burnup.controllers.Main"

])


@app.config(() ->
)

@app.run(($rootScope, Auth, amMoment) ->
  @App = {}
  App.cable = Cable.createConsumer "ws://#{ENV['CABLE_HOST'] ? ENV['CABLE_HOST'] : '127.0.0.1'}:28080"
  Auth.login()
  amMoment.changeLocale('fr')
)



$(document).on 'page:load', ->
  $('[ng-app]').each ->
    module = $(this).attr('ng-app')
    angular.bootstrap(this, [module])
