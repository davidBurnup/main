angular.module('Burnup.models.Comment', ['ngResource', 'rails'])

.factory 'Comment', ($resource, RailsResource, railsSerializer) ->

  class Comment extends RailsResource
    @configure

      url: (context) ->
        defaultUrl = '/api'

        console.log "ii", context
        if context.activityId
          defaultUrl += "/activites/#{context.activityId}/commentaires"

        if context.id
          defaultUrl += "/#{context.id}"

        defaultUrl += ".json"

        defaultUrl

      , name: 'comment'


  return Comment
