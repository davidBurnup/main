angular.module('Burnup.models.Church', ['ngResource', 'rails'])

.factory 'Church', ($resource, RailsResource, railsSerializer) ->

  class Church extends RailsResource
    @configure

      url: (context) ->
        defaultUrl = '/api/eglises'

        if context.id
          defaultUrl += "/#{context.id}"

        if context.search
          defaultUrl += "/recherche/#{context.search}"

        defaultUrl += ".json"

        defaultUrl

      , name: 'church'


  return Church
