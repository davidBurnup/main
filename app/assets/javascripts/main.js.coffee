ready = ->
  $('.autogrow').autoGrow()
  if($('[data-link-to]').length > 0)
    $('[data-link-to]').each ->
      link_to = $(this).attr('data-link-to')
      $(this).click ->
        window.location = link_to

$(document).ready(ready)
$(document).on('page:load', ready)