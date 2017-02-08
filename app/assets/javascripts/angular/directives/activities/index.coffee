angular.module('Burnup.directives.buActivitiesIndex', [])

.directive 'buActivitiesIndex', (Activity, $sce) ->
  {
    restrict: 'E'
    templateUrl: 'activities/index.html'
    # scope:
    #   activity: "="

    controller: ($scope) ->
      $scope.activities = []
      $scope.page = 0
      $scope.reachedLastPage = false
      $scope.activitiesLock = false

      $scope.loadActivities = (forceRefresh) ->

        if ((!$scope.reachedLastPage and !$scope.activitiesLock) or forceRefresh)

          if forceRefresh
            $scope.page = 0
            $scope.activities = null
            $scope.reachedLastPage = false

          $scope.activitiesLock = true
          $scope.page += 1

          Activity.get(page: $scope.page).then (activities) ->
            angular.forEach activities, (activity) ->
              activity.safeContent = $sce.trustAsHtml(activity.content)
              $scope.activities.push activity

            if activities.length == 0
              $scope.reachedLastPage = true
            $scope.activitiesLock = false

      $scope.loadActivities()


  }
