###
# Angular Justified Gallery
# (c) 2016 Jayesh Bhalodia
# License: MIT
###

do ->
  'use strict'
  angular.module 'angular-justified-gallery', []
  angular.module('angular-justified-gallery')
  .provider 'angular-justified-gallery', ->
    @defaults =
      rowHeight: 'bootstrap'
      position: 'top left'
      defaultValue: ''
      animationSpeed: 50
      animationEasing: 'swing'
      change: null
      changeDelay: 0
      control: 'hue'
      hide: null
      hideSpeed: 100
      inline: false
      letterCase: 'lowercase'
      opacity: false
      show: null
      showSpeed: 100
      lastRow: 'justify'

    @$get = ->
      this

    return
  angular.module('angular-justified-gallery').directive 'justifiedGallery', [
    '$timeout', '$rootScope'
    ($timeout, $rootScope) ->
      {
        restrict: 'E'
        replace: true
        scope:
          images: '=images'
          galleryName: "=galleryName"
        template: '<div class="angular-justified-gallery"><a ng-repeat="(i, img) in images" href="{{img.imageUrl}}" rel="{{galleryName}}"><img alt="{{img.title}}" src="{{img.imageUrl}}"/></a></div>'
        link: ($scope, element, attrs, ctrls, transclude) ->
          $scope.galleryName = "myGalerry" unless $scope.galleryName?
          $scope.$watch (->
            $scope.images
          ), ((value) ->
            $timeout (->


              element.justifiedGallery(
                lastRow: 'justify'
                captions: false
              ).on 'jg.complete', ->
                $(this).find('a').colorbox(
                  maxWidth: '100%'
                  maxHeight: '100%'
                  opacity: 0.8
                  transition: 'elastic'
                  current: ''
                  rel: $scope.galleryName
                  scrolling: false
                )
                $scope.$emit "masonry.reload" # Trigger masonry reload
                unless $rootScope.colorboxEventsAreSet
                  $(document)
                  .bind "cbox_open", ->
                    $('body').addClass('unscrollable')
                  .bind "cbox_closed", ->
                    $('body').removeClass('unscrollable')
                    $rootScope.pageIsUnscrollable = false
                  $rootScope.colorboxEventsAreSet = true
                return
              return
            ), 100
            return
          ), true
          return

      }
  ]
  return
