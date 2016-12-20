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
#= require cable
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
#= require mediaelement_rails
#= require angular
#= require angular-animate
#= require angular-resource
#= require angular-rails-templates
#= require_tree ../templates
#= require angularjs/rails/resource
#= require angular-moment/angular-moment.min
#= require angular-bootstrap/ui-bootstrap-tpls.min
#= require ngInfiniteScroll/build/ng-infinite-scroll.min

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
