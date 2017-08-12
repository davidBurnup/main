angular.module('Burnup.directives.buActivitiesNew', [])

.directive 'buActivitiesNew', (Activity, $sce, Auth, User, $timeout, $uibModal, $log) ->
  {
    restrict: 'EA'
    templateUrl: 'activities/new.html'
    scope:
      recipientType: "="
      recipientId: "="

    controller: ($scope) ->
      $scope.currentUser = Auth.currentUser()

      $scope.openModal = ($event, options) ->
        options = {} unless options
        $timeout ->
          t = $event.target
          t.blur()
          modalInstance = $uibModal.open(
            ariaLabelledBy: 'modal-title'
            ariaDescribedBy: 'modal-body'
            templateUrl: 'activities/new_modal.html'
            controller: 'ActivitiesNewModal'
            windowClass: if options.withPhoto? then 'slide-bottom' else 'slide-top'
            resolve:
              withPhoto: ->
                options.withPhoto?
              recipientType: ->
                $scope.recipientType
              recipientId: ->
                $scope.recipientId
          )
          modalInstance.result.then (post) ->
            if post
              new Activity(
                id: post.activityId
              ).get()
              .then (activity) ->
                $scope.$emit "activity:create:success", activity
                $scope.$emit "masonry:reload"
          , ->
            $log.info 'Modal dismissed at: ' + new Date
            return
        , 100

  }
