angular.module('Burnup.directives.buInstrumentPreferencesNew', ['selectize'])

.directive 'buInstrumentPreferencesNew', (InstrumentPreference, Auth, $timeout) ->
  {
    restrict: 'E'
    templateUrl: 'instrument_preferences/new.html'

    controller: ($scope) ->

      $scope.instrumentOptions = InstrumentPreference.instrumentKeys

      console.log "oko", $scope.instruments
      $scope.instrumentConfig =
        create: false
        valueField: 'key'
        labelField: 'label'
        searchField: ['label']
        delimiter: '|'
        placeholder: 'Instrument'
        onInitialize: (selectize) ->
          $scope.instrumentSelectize = selectize
        maxItems: 1

      $scope.setNewInstrument = ->
        $scope.instrument =
          userId: Auth.currentUser().id
          instrument: ""

      if Auth.currentUser()
        $scope.setNewInstrument()

      $scope.create = ->
        new InstrumentPreference($scope.instrument).create().then (instrument) ->
          $scope.$emit "instrument_preference:created", instrument
          $scope.setNewInstrument()

      $timeout ->
        $scope.ready = true
      , 1000
  }
