angular.module('Burnup.models.Page', ['ngResource', 'rails'])

.factory 'Page', ($resource, RailsResource, railsSerializer) ->

  class Page extends RailsResource
    @configure

      url: (context) ->
        defaultUrl = '/api/pages'

        if context.id
          defaultUrl += "/#{context.id}"

        if context.search
          defaultUrl += "/recherche/#{context.search}"

        defaultUrl += ".json"

        defaultUrl

      , name: 'page'

    toggleFollow: ->
      @.isFollowed = !@.isFollowed
      @.update()


  return Page
