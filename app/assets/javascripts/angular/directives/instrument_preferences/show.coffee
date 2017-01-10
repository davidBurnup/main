angular.module('Burnup.directives.buInstrumentPreferencesShow', [])

.directive 'buInstrumentPreferencesShow', (InstrumentPreference)->
  {
    restrict: 'E'
    templateUrl: 'instrument_preferences/show.html'
    scope:
      instrument: "=?"

    controller: ($scope) ->

      $scope.destroy = ->
        new InstrumentPreference($scope.instrument).delete().then ->
          $scope.$emit "instrument_preference:destroyed", $scope.instrument
  }
