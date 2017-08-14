angular.module('Burnup.directives.buActivitiesIndex', [])

.directive 'buActivitiesIndex', (Activity, $sce, Auth, User, $timeout) ->
  {
    restrict: 'E'
    templateUrl: 'activities/index.html'
    scope:
      singleColumn: "="
      recipientType: "="
      recipientId: "="
      writeModeEnabled: "="

    controller: ($scope) ->
      $scope.activities = []
      $scope.page = 0
      $scope.reachedLastPage = false
      $scope.activitiesLock = false
      $scope.initialized = false
      $scope.currentUser = Auth.currentUser(getInstance: true)

      $scope.loadActivities = (forceRefresh) ->

        if ((!$scope.reachedLastPage and !$scope.activitiesLock) or forceRefresh)

          if forceRefresh
            $scope.page = 0
            $scope.activities = null
            $scope.reachedLastPage = false

          $scope.activitiesLock = true
          $scope.page += 1

          Activity.get(
            recipientType: $scope.recipientType,
            recipientId: $scope.recipientId,
            page: $scope.page
          ).then (activities) ->
            angular.forEach activities, (activity) ->
              activity.safeContent = $sce.trustAsHtml(activity.content)
              $scope.activities.push activity

            if activities.length == 0
              $scope.reachedLastPage = true
            $scope.activitiesLock = false
            $scope.initialized = true
            $timeout ->
              $scope.$emit "masonry.reload"

      $scope.loadActivities()

      $scope.$on "activity:create:success", (e, activity) ->
        $scope.activities.splice 0, 0, activity

      $scope.$on "activity:destroy:success", (e, activityId) ->
        $scope.activities = $scope.activities.filter (inMemoryActivity) ->
          inMemoryActivity.id isnt activityId
        $scope.$broadcast "masonry:reload"

  }
