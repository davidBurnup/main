angular.module('Burnup.directives.buActivitiesIndex', [])

.directive 'buActivitiesIndex', (Activity) ->
  {
    restrict: 'E'
    templateUrl: 'activities/index.html'
    # scope:
    #   activity: "="

    controller: ($scope) ->
      $scope.activities = []

      Activity.get().then (activities) ->
        $scope.activities = activities



  }
