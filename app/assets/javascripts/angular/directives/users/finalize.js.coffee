angular.module('Burnup.directives.buUsersFinalize', ['ngImgCrop', 'ngFileUpload', 'angular-svg-round-progressbar'])

.directive 'buUsersFinalize', (User, SelectizeTemplator, $filter, Auth, Page, Upload) ->
  {
    restrict: 'E'
    templateUrl: 'users/finalize.html'
    # scope:
    #   user: "="

    controller: ($scope, $uibModal, $timeout, User) ->

      $scope.currentUser = Auth.currentUser()
      $scope.pages = []
      $scope.page = {}

      $scope.$watch "page.name", (pageName) ->
        console.log "pageName", pageName
        $scope.pages = []
        $scope.searchingPages = true
        Page.query(search: pageName).then (pages) ->
          $scope.pages = pages
          $scope.searchingPages = false

      $scope.$on "page:unselect", (e, page) ->
        $scope.currentUser.page_id = null
        new User($scope.currentUser).save().then ->
          Auth.setCurrentUser($scope.currentUser)

      $scope.$on "page:select", (e, page) ->
        $scope.currentUser.page_id = page.id
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
