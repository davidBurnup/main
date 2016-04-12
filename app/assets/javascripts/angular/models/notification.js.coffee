angular.module('Burnup.models.Notification', ['ngResource'])

.factory 'Notification', ($resource, $http) ->

  class Notification
    @data = {}
    @service = null


    constructor: (id) ->
      @id = id
      @service = $resource('/notifications/:id.json', {
          id: id
        })

    all: (callback) ->
      @service.query(callback)

    # destroy: ->
    #   @service.$delete((response) ->
    #     response
    #   )



  return Notification
