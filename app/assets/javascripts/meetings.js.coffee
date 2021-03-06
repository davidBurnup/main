auto_load ->
  if $('#meetings').length > 0
    $('#meetings').fullCalendar({
      lang : "fr",
      height: cal_height(),
      eventSources: [
        url: '/reunions.json',
        type: 'GET',
        data: {
        },
        error: ->
          alert "Une erreur s'est produite"
        ,
      ],
      eventClick: (calEvent, jsEvent, view) ->
        $.ajax
          url: calEvent.url
        jsEvent.preventDefault()
      ,
      handleWindowResize:true,
      dayClick: (date, jsEvent, view) ->
        date.set('minute',0)
        date.set('hour', 10)
        console.log date
        $.ajax
          url: "reunions/new.js"
          data:
            date: date.format("DD/MM/YYYY HH:mm")
        return
    })

    load_chosens()
    $(window).resize ->
      resize_cal()

@resize_cal = ->
  $('#meetings').fullCalendar('option', 'height', cal_height())
  $('main.container').height(cal_height())

@cal_height = ->
  if $('.alert').length > 0 and $('.alert').is(':visible')
    cal_height = $(window).height() - 190
    $('.alert .close').click (e) ->
      jQuery(this).closest('.alert').hide()
      resize_cal()
      e.preventDefault()
      e.stopPropagation()
      return false

  else
    cal_height = $(window).height() - 120
  cal_height
@load_chosens = ->
  $('.chosen').chosen
    allow_single_deselect: true
    no_results_text: 'Aucun résultats trouvés'
    width: '100%'
