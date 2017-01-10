angular.module('Burnup.directives.buInstrumentPreferencesIndex', [])

.directive 'buInstrumentPreferencesIndex', (InstrumentPreference, Auth) ->
  {
    restrict: 'E'
    templateUrl: 'instrument_preferences/index.html'
    controller: ($scope) ->

      $scope.currentUser = Auth.currentUser()
      InstrumentPreference.query().then (instruments) ->
        $scope.instruments = instruments

      $scope.$on "instrument_preference:destroyed", (e, destroyedInstrument) ->
        $scope.instruments = $scope.instruments.filter (instrument) ->
          instrument.id isnt destroyedInstrument.id

      $scope.$on "instrument_preference:created", (e, createdInstrument) ->
        $scope.instruments.push createdInstrument

  }
