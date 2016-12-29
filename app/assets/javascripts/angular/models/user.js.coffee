angular.module('Burnup.models.User', ['ngResource', 'rails'])

.factory 'User', ($resource, RailsResource, railsSerializer) ->

  class User extends RailsResource
    @configure

      url: (context) ->
        defaultUrl = '/api/utilisateurs'

        if context.id
          defaultUrl += "/#{context.id}"

        defaultUrl += ".json"

        defaultUrl

      , name: 'user'


  return User
