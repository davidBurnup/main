angular.module('Burnup.directives.buActivitiesShow', [])

.directive 'buActivitiesShow', (Activity, $sce, Auth, User, $timeout, $uibModal) ->
  {
    restrict: 'AE'
    templateUrl: 'activities/show.html'
    scope:
      activity: "="

    controller: ($scope, Auth, $timeout) ->

      $scope.currentUser = Auth.currentUser()

      $scope.compileLikeLabel = (activity) ->
        label = ""
        # console.log "activity",activity
        if activity.liked
          label = "Vous"
          if activity.likers.length > 0
            if activity.likers.length == 1
              label += " et "
            else
              label += ", "
          else
            label += " "

        for liker, i in activity.likers

          if liker.name and liker.id != $scope.currentUser.id
            label += "#{liker.name}"

          # Choose separator
          if i >= 2 or (activity.likers.length > 1 and i == (activity.likers.length - 2))
            label += " et "
          else if activity.likers.length > 2 and i < (activity.likers.length - 2)
            label += ", "

          # Break the loop if more than 2 iterations
          if i >= 1
            label += "#{activity.likers.length - 2} autre#{if activity.likers.length > 3 then 's' else ''} personne#{if activity.likers.length > 3 then 's' else ''} "
            break

        if activity.likers.length > 0 or activity.liked
          label += " brul#{if activity and activity.liked then 'ez' else (if activity.likers.length > 1 then "ent" else "e")} pour ceci."
        else
          label += "Ça fait bruler mon coeur !"

        # console.log "label", label
        return label

      $scope.$watch "activity", (activity) ->
        $scope.$broadcast "activity:refresh:likeLabel"

      $scope.$on "activity:refresh:likeLabel", ->
        $scope.activity.likeLabel = $scope.compileLikeLabel($scope.activity)

      $scope.burnToggle = ->
        $scope.activity.liked = !$scope.activity.liked
        if $scope.activity and $scope.currentUser
          new User(
            id: $scope.currentUser.id
            activityId: $scope.activity.id
          ).update().then (activity) ->
            $scope.activity.likers = activity.likers
            $scope.$broadcast "activity:refresh:likeLabel"

      $scope.showLikers = ->
        if $scope.activity.likers.length > 2
          $uibModal.open(
            templateUrl: 'activities/likers_modal.html',
            controller: 'ActivitiesLikersModal',
            size: 'sm'
            resolve:
              likers: ->
                $scope.activity.likers
          )

  }
