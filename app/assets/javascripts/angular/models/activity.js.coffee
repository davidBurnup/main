angular.module('Burnup.models.Activity', ['ngResource', 'rails'])

.factory 'Activity', ($resource, RailsResource, railsSerializer) ->

  class Activity extends RailsResource
    @configure

      url: (context) ->
        defaultUrl = '/api/activites'

        if context.id
          defaultUrl += "/#{context.id}"

        if context.page
          defaultUrl += "/page/#{context.page}"

        defaultUrl += ".json"

        defaultUrl

      , name: 'activity'


  return Activity
