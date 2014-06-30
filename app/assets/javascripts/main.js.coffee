ready = ->
  $("#user_avatar").filestyle({
    size: "sm",
    input: false,
    iconName: "glyphicon-camera",
    buttonText: "Changer la photo"
  })
  $('.link_to_print').click ->
    window.print()
  $('.autogrow').autoGrow()
  if($('[data-link-to]').length > 0)
    $('[data-link-to]').each ->
      link_to = $(this).attr('data-link-to')
      $(this).click ->
        window.location = link_to
  main_container()
#  public_background()
  ref_el = $('body > main.container')
  verticalAlign($('#public-right-pane'),ref_el)
  verticalAlign($('#public-left-pane'),ref_el)

  $(window).resize ->
    public_background()
    verticalAlign($('#public-right-pane'))
    verticalAlign($('#public-left-pane'))
    main_container()

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
  $(document).on('page:load', ready_var)

auto_load(ready)