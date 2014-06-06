# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->
  if $("#song-container").length > 0

    line_height = 80
    offset_width = 5.6

    content_notes = $('#song-container .content-note')

    note_index = 0
    $('#song-notes > div.note').each ->
      offset = $(this).attr('data-offset')
      line = $(this).attr('data-line')
      content_note = content_notes[note_index]

      real_line = (line_height * (line - 1))
      real_offset = (offset_width * offset)

      if content_note
        real_offset = $(content_note).position().left
        real_line = $(content_note).position().top - 20

      $(this).css('top', real_line + "px")
      $(this).css('left', real_offset + "px")
      note_index += 1



  if $('form.edit_user_song_preference').length > 0
    $('form.edit_user_song_preference').find('input, select').each ->
      $(this).change ->
        console.log('in')
        $('form.edit_user_song_preference').submit()