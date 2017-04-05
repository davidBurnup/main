angular.module('Burnup.directives.buActivitiesNew', [])

.directive 'buActivitiesNew', (Activity, $sce, Auth, User, $timeout) ->
  {
    restrict: 'EA'
    templateUrl: 'activities/new.html'
    # scope:
    #   activity: "="

    controller: ($scope) ->
      $scope.currentUser = Auth.currentUser()


  }
