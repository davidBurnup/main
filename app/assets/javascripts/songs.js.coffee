# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


@load_chords = ->
  setTimeout (->
    if $("#song-container").length > 0

      # Add empty class for empty lines
      $('.song-line').each ->
        line = $(this).text().trim()
        if line == ""
          $(this).addClass('empty-song-line')
          # $(this).remove()

      line_height = 80
      offset_width = 5.6


      note_index = 0


      lines_count = $('#song-container .song-line:not(.empty-song-line)').length
      available_lines = []

      i = 1
      while i <= lines_count
        available_lines.push i
        i++

      lines_with_notes = $.unique($.map($('#song-notes > div.note'), (val, i) ->
        parseInt($(val).attr('data-line'));
      ))
      console.log(lines_with_notes)

      lines_with_no_chords = arr_diff(available_lines,lines_with_notes)
      lines_to_consider = $('#song-container .song-line:not(.empty-song-line)')
      for line_num in lines_with_no_chords
        if lines_to_consider[line_num - 1]
          $(lines_to_consider[line_num - 1]).addClass('no-chord')


      content_notes = $('#song-container .content-note')
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

      $('#song-container').removeClass('loading')
  ), 200
ready = ->
  load_chords()


  if $('form.edit_user_song_preference').length > 0
    $('form.edit_user_song_preference').find('input, select').each ->
      $(this).change ->

        $('#song-container').addClass('loading')
        $('form.edit_user_song_preference').submit()



$(document).ready(ready)
$(document).on('page:load', ready)

@arr_diff = (a1, a2) ->
  a = []
  diff = []
  i = 0
  while i < a1.length
    a[a1[i]] = true
    i++

  i = 0
  while i < a2.length
    if a[a2[i]]
      delete a[a2[i]]
    else
      a[a2[i]] = true
    i++
  for k of a
    diff.push k
  diff
