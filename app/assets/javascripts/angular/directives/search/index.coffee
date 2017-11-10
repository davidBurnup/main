angular.module('Burnup.directives.buSearchIndex', [])

.directive 'buSearchIndex', () ->
  {
    restrict: 'E'
    templateUrl: 'search/index.html'
    # scope:

    controller: ($scope, $http, $window) ->
      $scope.searchTerm = ""
      $scope.searchValues = {}
      $scope.getSearch = (val) ->
        $http.get("/api/recherche/#{val}.json")
        .then (response) ->
          console.log "results", response.data

          # Copy search in cache search values
          for result in response.data
            $scope.searchValues[result.search_label] = result

          return response.data.map (result) ->
            return result.search_label

      $scope.onSelect = ($item, $model, $label, $event) ->
        selectedItem = $scope.searchValues[$item]
        $window.location = selectedItem.show_url

  }
