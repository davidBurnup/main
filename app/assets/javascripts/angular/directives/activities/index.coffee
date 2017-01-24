angular.module('Burnup.directives.buActivitiesIndex', [])

.directive 'buActivitiesIndex', (Activity, $sce) ->
  {
    restrict: 'E'
    templateUrl: 'activities/index.html'
    # scope:
    #   activity: "="

    controller: ($scope) ->
      $scope.activities = []

      Activity.get().then (activities) ->
        angular.forEach activities, (activity) ->
          activity.safeContent = $sce.trustAsHtml(activity.content)
          $scope.activities.push activity



  }
