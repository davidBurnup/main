@load_media_element_player = ->
  $('video,audio').mediaelementplayer()
@load_filestyle = ->
  $(".filestyle").each ->
    $(this).filestyle({
      size: $(this).attr('data-size'),
      input: false,
      iconName: $(this).attr('data-iconName'),
      buttonText: $(this).attr('data-buttonText')
    })
@loadAutoGrow = ->
  $('.autogrow').autoGrow()
@global_ready = ->
  tabs_auto_load()
  $('[data-behaviour~=datepicker]').datetimepicker({
    language: "fr",
  })
  $("#user_avatar").filestyle({
    size: "sm",
    input: false,
    iconName: "glyphicon-camera",
    buttonText: "Changer la photo"
  })
  # load_media_element_player();
  # load_filestyle();
  $('.link_to_print').click ->
    window.print()
  # loadAutoGrow()
  if($('[data-link-to]').length > 0)
    $('[data-link-to]').each ->
      link_to = $(this).attr('data-link-to')
      $(this).click ->
        window.location = link_to

  window.is_public = $('body').hasClass("public")

  if is_public
    main_container()
  else
    $('body > main.container').css('height', '')
#  public_background()
  ref_el = $('body > main.container')
  verticalAlign($('#public-right-pane'),ref_el)
  verticalAlign($('#public-left-pane'),ref_el)

  $(window).resize ->
    if is_public
      public_background()
      verticalAlign($('#public-right-pane'))
      verticalAlign($('#public-left-pane'))
      main_container()
    else
      $('body > main.container').css('height', '')

  parallax()
  $(window).scroll (e) ->
    parallax()


@parallax = ->
  scrolled = $(window).scrollTop()
  $("body").css "background-position", "0 " + -(scrolled * 0.15) + "px"
@public_background = ->
  window_height = $(window).height() - $('header > .navbar').height() - $('footer').height()
  $('body.public').height(window_height)
@main_container = ->
  window_height = $(window).innerHeight() - $('header > .navbar').outerHeight() - $('footer').outerHeight() - 10
  main_height = $('body > main.container').innerHeight()
  if(main_height < window_height)
    $('body > main.container').innerHeight(window_height)

@verticalAlign = (el, ref_el)->
  setTimeout (->
    if(ref_el==undefined)
      window_height = $(window).innerHeight() - 100
    else
      window_height = $(ref_el).innerHeight()
    el_height = $(el).innerHeight()
    if(el_height < window_height)
      diff = window_height - el_height
      $(el).css('margin-top', diff/2)
  ), 100
@auto_load = (ready_var) ->
  $(document).ready(ready_var)
  $(document).on('turbolinks:load', ready_var)

@tabs_auto_load = ->

  $('ul.nav-tabs > li > a').click (e) ->
    $(this).tab 'show'
    e.preventDefault()

  # store the currently selected tab in the hash value
  $('ul.nav-tabs > li > a').on 'shown.bs.tab', (e) ->
    id = $(e.target).attr('href').substr(1)
    scrollmem = $('html,body').scrollTop()
    window.location.hash = id
    $('html,body').scrollTop(scrollmem)
    return

  # on load of the page: switch to the currently selected tab
  hash = window.location.hash
  $('ul.nav-tabs > li > a[href="' + hash + '"]').tab 'show'

auto_load(global_ready)
