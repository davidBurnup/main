angular.module('Burnup.directives.buInstrumentPreferencesNew', [])

.directive 'buInstrumentPreferencesNew', (InstrumentPreference, Auth) ->
  {
    restrict: 'E'
    templateUrl: 'instrument_preferences/new.html'

    controller: ($scope) ->

      $scope.setNewInstrument = ->
        $scope.instrument =
          userId: Auth.currentUser().id

      if Auth.currentUser()
        $scope.setNewInstrument()

      $scope.create = ->
        new InstrumentPreference($scope.instrument).create().then (instrument) ->
          $scope.$emit "instrument_preference:created", instrument
          $scope.setNewInstrument()
  }
