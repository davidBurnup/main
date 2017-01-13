angular.module('Burnup.directives.buUsersFinalize', ['ngImgCrop', 'ngFileUpload', 'angular-svg-round-progressbar'])

.directive 'buUsersFinalize', (User, SelectizeTemplator, $filter, Auth, Church, Upload) ->
  {
    restrict: 'E'
    templateUrl: 'users/finalize.html'
    # scope:
    #   user: "="

    controller: ($scope, $uibModal, $timeout, User) ->

      $scope.currentUser = Auth.currentUser()
      $scope.churches = []
      $scope.church = {}

      $scope.$watch "church.name", (churchName) ->
        console.log "churchName", churchName
        $scope.churches = []
        $scope.searchingChurches = true
        Church.query(search: churchName).then (churches) ->
          $scope.churches = churches
          $scope.searchingChurches = false

      $scope.$on "church:unselect", (e, church) ->
        $scope.currentUser.church_id = null
        new User($scope.currentUser).save().then ->
          Auth.setCurrentUser($scope.currentUser)

      $scope.$on "church:select", (e, church) ->
        $scope.currentUser.church_id = church.id
        new User($scope.currentUser).save().then ->
          Auth.setCurrentUser($scope.currentUser)

      $scope.avatarImage = ''
      $scope.avatarImage = ''

      handleFileSelect = (evt) ->
        file = evt.currentTarget.files[0]
        reader = new FileReader()

        reader.onload = (evt) ->
          $scope.$apply ($scope) ->
            $scope.avatarImage = evt.target.result
            return
          return

        reader.readAsDataURL file
        return

      angular.element(document.querySelector('#avatarFileInput')).on 'change', handleFileSelect

      $scope.$watch "avatarValidated", (avatarValidated) ->
        if avatarValidated and $scope.avatarImage and $scope.croppedAvatarImage
          $scope.avatarUploading = true
          Upload.upload(
            url: "/api/utilisateurs/#{$scope.currentUser.id}.json"
            method: 'PUT'
            data:
              "user[avatar]": Upload.dataUrltoBlob($scope.croppedAvatarImage, $scope.avatarImage.name))

          .then ((response) ->
            $scope.avatarUploading = false
            $timeout ->
              $scope.result = response.data
              $scope.avatarUploaded = true
              return
            return

          ), ((response) ->
            $scope.avatarUploading = false
            if response.status > 0
              $scope.errorMsg = response.status + ': ' + response.data
            return

          ), (evt) ->
            $scope.progress = parseInt(100.0 * evt.loaded / evt.total)
            return
          return

      $scope.finalize = ->
        u = $scope.currentUser
        u.isFinalized = true
        $scope.finalizing = true
        new User(u).save().then ->
          Auth.setCurrentUser($scope.currentUser)
          window.location = "/"



  }
