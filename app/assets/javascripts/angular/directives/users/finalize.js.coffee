angular.module('Burnup.directives.buUsersFinalize', [])

.directive 'buUsersFinalize', (User, SelectizeTemplator, $filter, Auth, Church) ->
  {
    restrict: 'E'
    templateUrl: 'users/finalize.html'
    # scope:
    #   user: "="

    controller: ($scope, $uibModal, $timeout) ->

      $scope.currentUser = Auth.currentUser()
      $scope.churches = []
      $scope.church = {}

      $scope.$watch "church.name", (churchName) ->
        console.log "churchName", churchName
        if churchName?
          $scope.churches = []
          $scope.searchingChurches = true
          Church.query(search: churchName).then (churches) ->
            $scope.churches = churches
            $scope.searchingChurches = false

      $scope.$on "church:select", (e, church) ->
        console.log "chosen", church

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
