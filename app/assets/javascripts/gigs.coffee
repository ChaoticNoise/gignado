# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $("#gigs-sync").click ->
    $("#gigs-sync i.fa.fa-refresh").addClass("fa-spin")

    gigSync = (job_id) ->
      setTimeout( ->
        $.getJSON "/gigs/sync", {job_id: job_id}, (data, textStatus) ->
          if data.status == 'completed'
            $.get '/gigs/async_grid', ->
              $("#gigs-sync i.fa.fa-refresh").removeClass("fa-spin")
          else
            gigSync(data.job_id)
      , 3000)

    gigSync("")
