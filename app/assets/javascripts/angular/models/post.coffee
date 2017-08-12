angular.module('Burnup.models.Post', ['ngResource', 'rails'])

.factory 'Post', ($resource, RailsResource, railsSerializer) ->

  class Post extends RailsResource
    @configure

      url: (context) ->
        defaultUrl = '/api/publications'

        if context.id
          defaultUrl += "/#{context.id}"

        defaultUrl += ".json"

        defaultUrl

      , name: 'post'


  return Post
