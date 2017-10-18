angular.module('Burnup.directives.buActivitiesShow', [])
.directive 'buActivitiesShow', (Activity, $sce, Auth, User, $timeout, $uibModal, $http) ->
  {
    restrict: 'AE'
    templateUrl: 'activities/show.html'
    scope:
      activity: "=?"
      activityId: "=?"

    controller: ($scope, Auth, $timeout, Comment) ->

      $scope.currentUser = Auth.currentUser()
      $scope.isLoggedIn = Auth.isLoggedIn()

      if $scope.activityId?
        Activity.get(
          id: $scope.activityId
        ).then (activity) ->
          $scope.$emit "activity:loaded", activity
          $scope.activity = activity

      $scope.compileLikeLabel = (activity) ->
        label = ""
        if $scope.currentUser?
          other_likes_count = activity.likers.length
          if activity.liked
            label = "Vous"
            other_likes_count -= 1
            if activity.likers.length > 1
              if activity.likers.length == 2
                label += " et "
              else
                label += ", "
            else
              label += " "

          for liker, i in activity.likers

            if liker? and liker.id? and liker.name and liker.id != $scope.currentUser.id
              label += "#{liker.name}"

            if other_likes_count > 1
              # Choose separator
              if i >= 2 or (other_likes_count > 1 and i == (activity.likers.length - 2))
                label += " et "
              else if other_likes_count > 2 and i < (activity.likers.length - 2)
                label += ", "

              # Break the loop if more than 2 iterations
              if i >= 1
                label += "#{activity.likers.length - 2} autre#{if activity.likers.length > 3 then 's' else ''} personne#{if activity.likers.length > 3 then 's' else ''} "
                break

          if activity.likers.length > 0 or activity.liked
            label += " brul#{if activity and activity.liked then 'ez' else (if activity.likers.length > 1 then "ent" else "e")} pour ceci."
          else
            label += "Ça fait bruler mon coeur !"

        return label

      $scope.$watch "activity", (activity) ->
        if $scope.activity?
          $scope.activity.safeContent = $sce.trustAsHtml(activity.content);
          $scope.activity.mediasForJG = []
          if $scope.activity.medias?
            for media in $scope.activity.medias
              if media.image?
                $scope.activity.mediasForJG.push {
                  title: "ttt"
                  imageUrl: media.image.original
                }
          $scope.$broadcast "activity:refresh:likeLabel"

      $scope.$on "activity:refresh:likeLabel", ->
        $scope.activity.likeLabel = $scope.compileLikeLabel($scope.activity)

      $scope.saveComment = (e, comment) ->
        e.preventDefault()
        unless comment.saving
          comment.saving = true
          $http.post("/api/activites/#{$scope.activity.id}/commentaires.json",
            comment: comment
          ).then (response) ->
            comment.saving = false
            $scope.activity.comments.push xcase.camelizeKeys(response.data)
            $scope.activity.comment = new Comment(
              activityId: $scope.activity.id
            ) # Fill in a brand new comment
            $scope.$emit "masonry.reload"

      $scope.toggleComment = ->
        $scope.activity.showComments = !$scope.activity.showComments
        $scope.activity.comment = new Comment(
          activityId: $scope.activity.id
        ) # Fill in a brand new comment

        $scope.activity.commentInputFocus = true
        $scope.$emit "masonry.reload"

      $scope.destroyComment = (comment) ->
        if confirm("Voulez-vous vraiment supprimer ce commentaire ?")
          new Comment(
            activityId: $scope.activity.id
            id: comment.id
          ).delete().then ->

            $scope.activity.comments = $scope.activity.comments.filter (oldComment) ->
              oldComment.id isnt comment.id

            $scope.$emit "masonry.reload"

      $scope.burnToggle = ->
        $scope.activity.liked = !$scope.activity.liked
        $scope.$emit "masonry.reload"
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
      $scope.destroy = (e, activity) ->
        e.preventDefault()
        activity.delete()
        .then ->
          $scope.$emit "activity:destroy:success", activity.id

  }
