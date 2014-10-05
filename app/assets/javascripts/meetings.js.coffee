auto_load ->
  cal_height = $(window).height() - 200
  $('#meetings').fullCalendar({
    lang : "fr",
    height: cal_height,
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
    handleWindowResize:true
  })

  load_chosens()

@load_chosens = ->
  $('.chosen').chosen
    allow_single_deselect: true
    no_results_text: 'Aucun résultats trouvés'
    width: '100%'
