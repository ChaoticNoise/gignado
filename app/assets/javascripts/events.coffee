# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $("#events-sync").click ->
    $("#events-sync i.fa.fa-refresh").addClass("fa-spin")

    eventSync = (job_id) ->
      setTimeout( ->
        $.getJSON "/events/sync", {job_id: job_id}, (data, textStatus) ->
          if data.status == 'completed'
            $.get '/events/async_grid', ->
              $("#events-sync i.fa.fa-refresh").removeClass("fa-spin")
          else
            eventSync(data.job_id)
      , 3000)

    eventSync("")
