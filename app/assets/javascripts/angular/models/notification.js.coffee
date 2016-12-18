angular.module('Burnup.models.Notification', ['ngResource', 'rails'])

.factory 'Notification', ($resource, RailsResource, railsSerializer) ->

  class Notification extends RailsResource
    @configure

      url: (context) ->
        defaultUrl = '/api/notifications'

        if context.id
          defaultUrl += "/#{context.id}"

        if context.page
          defaultUrl += "/page/#{context.page}"

        defaultUrl += ".json"

        defaultUrl

      , name: 'notification'

    @intercept 'response', (result, resourceConstructor) ->
      if angular.isDefined(result.originalData.count)
        result.data = result.originalData.items
        result.data.$count = result.originalData.count
        result.data.$unseenCount = result.originalData.unseen_count
      result

  return Notification
