angular.module('Burnup.directives.buActivitiesIndex', [])

.directive 'buActivitiesIndex', (Activity, $sce, Auth, User, $timeout) ->
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

          Activity.get(page: $scope.page).then (activities) ->
            angular.forEach activities, (activity) ->
              activity.safeContent = $sce.trustAsHtml(activity.content)
              $scope.activities.push activity

            if activities.length == 0
              $scope.reachedLastPage = true
            $scope.activitiesLock = false
            $scope.initialized = true

      $scope.loadActivities()

      $scope.$on "post:create:success", (e, activity) ->
        $scope.activities.splice 0, 0, activity


  }
