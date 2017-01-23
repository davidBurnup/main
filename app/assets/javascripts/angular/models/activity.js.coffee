angular.module('Burnup.models.Activity', ['ngResource', 'rails'])

.factory 'Activity', ($resource, RailsResource, railsSerializer) ->

  class Activity extends RailsResource
    @configure

      url: (context) ->
        defaultUrl = '/api/activites'

        if context.id
          defaultUrl += "/#{context.id}"

        defaultUrl += ".json"

        defaultUrl

      , name: 'activity'


  return Activity
