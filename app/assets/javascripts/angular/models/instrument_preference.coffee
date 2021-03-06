angular.module('Burnup.models.InstrumentPreference', ['ngResource', 'rails'])

.factory 'InstrumentPreference', ($resource, RailsResource, railsSerializer, $rootScope) ->

  class InstrumentPreference extends RailsResource
    @configure
      url: (context) ->
        defaultUrl = '/api/instruments'

        if context.id
          defaultUrl += "/#{context.id}"

        defaultUrl += ".json"

        defaultUrl

      , name: 'instrument_preference'

    @instrumentKeys: $rootScope.instrumentKeys


  return InstrumentPreference
