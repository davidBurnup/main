# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require bootstrap
#= require bootstrap-filestyle.min
#= require action_cable
#= require "jquery.autogrowtextarea"
#= require cocoon
#= require moment/min/moment.min
#= require moment/locale/fr
#= require bootstrap-datetimepicker
#= require locales/bootstrap-datetimepicker.fr.js
#= require fullcalendar/fullcalendar.min
#= require fullcalendar/fr
#= require chosen-jquery
#= require jquery-hotkeys
#= require angular
#= require angular-sanitize
#= require angular-animate
#= require angular-resource
#= require selectize/dist/js/standalone/selectize.min
#= require angular-selectize2/dist/angular-selectize
#= require angular-rails-templates
#= require_tree ../templates
#= require angularjs/rails/resource
#= require angular-elastic/elastic
#= require angular-loading-bar/build/loading-bar.min
#= require justifiedGallery/dist/js/jquery.justifiedGallery.min
#= require jquery-colorbox/jquery.colorbox-min
#= require jquery-colorbox/i18n/jquery.colorbox-fr
#= require angular-audio/app/angular.audio.js
#= require angular-socialshare/dist/angular-socialshare.min

# POST ANGULAR MODULES
#= require angular-moment/angular-moment.min
#= require angular-bootstrap/ui-bootstrap-tpls.min
#= require ngInfiniteScroll/build/ng-infinite-scroll.min
#= require ng-img-crop-full-extended/compile/minified/ng-img-crop
#= require ng-file-upload/ng-file-upload.min
#= require angular-svg-round-progressbar/build/roundProgress.min
#= require xcase/dist/xcase.min

# MASONRY
#= require ev-emitter/ev-emitter
#= require jquery-bridget/jquery-bridget
#= require desandro-matches-selector/matches-selector
#= require fizzy-ui-utils/utils
#= require get-size/get-size
#= require outlayer/item
#= require outlayer/outlayer
#= require imagesloaded/imagesloaded
#= require masonry/masonry
#= require angular-masonry/angular-masonry

# Order matters ! load first deps (controllers, directives, filters)
#= require_tree ./angular/models
#= require_tree ./angular/services
#= require_tree ./angular/controllers
# require_tree ./angular/filters
#= require_tree ./angular/directives

# Then init the app !
#= require ./angular/app
#= require main
#= require feeds
#= require songs
#= require meetings
