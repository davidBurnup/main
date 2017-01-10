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

      $scope.myImage = ''
      $scope.myCroppedImage = ''

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
      # $scope.selectizeConfig =
      #   persist: false,
      #   maxItems: 1,
      #   valueField: 'id'
      #   labelField: 'name'
      #   searchField: [
      #     'name'
      #   ],
      #   create: true,
      #   render: {
      #
      #     option_create: (item, escape) ->
      #       "<div class=\"create\">Ajouter \"#{escape(item.input)}\"<i></i></div>"
      #
      #     item: (item, escape) ->
      #       html = SelectizeTemplator.compile('churches/_selectize.html', item, escape)
      #       return html
      #
      #     option: (item, escape) ->
      #       html = SelectizeTemplator.compile('churches/_selectize.html', item, escape)
      #       return html
      #   }
      #
      #   load: (query, callback) ->
      #     if (!query.length)
      #       return callback()
      #     $scope.churches = []
      #     $scope.searchingChurches = true
      #     Church.query(search: query).then (churches) ->
      #       $scope.churches = churches
      #       $scope.searchingChurches = false
      #       callback(churches)
      #     , ->
      #       callback()
      #     # $http(
      #     #   url: "/recherche/themes/#{encodeURI(query)}.json",
      #     #   # url: "/themes/#{encodeURI(query)}.json",
      #     #   method: 'GET'
      #     #   ).then((res) ->
      #     #     callback(res.data)
      #     #     $scope.searchedThemes = res.data
      #     #   , ->
      #     #     callback()
      #     #   )
      #
      #   onInitialize: (selectizeObject) ->
      #     $scope.selectizeObject = selectizeObject
      #
      #     selectizeObject.on "blur", ->
      #       selectedChurchId = $scope.user.church_id
      #       selectedChurches = $scope.churches.filter (church) ->
      #         parseInt(church.id) is parseInt(selectedChurchId)
      #
      #       $scope.selectizeObject.clearOptions()
      #
      #       $scope.churches = selectedChurches
      #       $scope.user.church_id = selectedChurchId
      #
      #       # $scope.churches = $scope.churches.filter (church) ->
      #       #   parseInt(church.id) is parseInt($scope.user.church_id)
      #       $scope.$apply()
      #
      #   create: (name, callback) ->
      #     $scope.creatingChurch = true
      #     new Church(name: name).save().then (church) ->
      #       $scope.churches.push church
      #       $scope.user.church_id = church.id
      #       $scope.creatingChurch = false
      #     return false
      #
      #   createFilter: (input) ->
      #     if input.length > 0
      #       if @options
      #         options = @options
      #         mappedOptions = Object.keys(options).map (key) ->
      #           {
      #             id: options[key].id
      #             name: angular.lowercase(options[key].name)
      #           }
      #         foundElement = $filter('filter')(mappedOptions, {name: angular.lowercase(input)}, true)
      #         if foundElement.length == 0
      #           return true
      #       else
      #         return true
      #     return false


  }
