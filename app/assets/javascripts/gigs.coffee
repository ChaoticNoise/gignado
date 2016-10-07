# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->

  # Gigs index async with gigomatic
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

  # Gig Form
  $(".form-group.gig_end_date_display").hide()

  if $("form.edit_gig").length > 0
    start_time = new Date($("input#gig_start_time").val())
    end_time = new Date($("input#gig_end_time").val())
    start_date = strftime("%b %e, %Y", start_time)
    end_date = strftime("%b %e, %Y", end_time)
    $("input#gig_start_date_display").val(start_date)
    $("input#gig_start_time_display").val(strftime("%l:%M %p", start_time))
    $("input#gig_end_time_display").val(strftime("%l:%M %p", end_time))

    if !!$("input#gig_call_time").val()
      call_time = new Date($("input#gig_call_time").val())
      $("input#gig_call_time_display").val(strftime("%l:%M %p", call_time))

    if !!$("input#gig_confirmation_deadline").val()
      deadline = new Date($("input#gig_confirmation_deadline").val())
      $("input#gig_confirmation_deadline_display").val(strftime("%b %e, %Y", deadline))

    if start_date != end_date
      $("input#gig_end_date_display").val(end_date)
      $(".form-group.gig_multi_day").hide()
      $(".form-group.gig_end_date_display").show()

  $("input#gig_multi_day").click ->
    $(".form-group.gig_multi_day").hide()
    $(".form-group.gig_end_date_display").show()

  update_gig_start_time = ->
    start_date = $("input#gig_start_date_display").val()
    start_time = $("input#gig_start_time_display").val()
    $("input#gig_start_time").val(new Date("#{start_date} #{start_time}").toISOString())

  update_gig_end_time = ->
    start_date = $("input#gig_start_date_display").val()
    end_date = $("input#gig_end_date_display").val()
    end_date = if !!end_date then end_date else start_date
    end_time = $("input#gig_end_time_display").val()
    $("input#gig_end_time").val(new Date("#{end_date} #{end_time}").toISOString())

  update_gig_call_time = ->
    start_date = $("input#gig_start_date_display").val()
    call_time = $("input#gig_call_time_display").val()
    if !!call_time
      $("input#gig_call_time").val(new Date("#{start_date} #{call_time}").toISOString())

  update_deadline = ->
    deadline = $("input#gig_confirmation_deadline_display").val()
    if !!deadline
      $("input#gig_confirmation_deadline").val(new Date("#{deadline}").toISOString())

  $("input#gig_start_date_display").change ->
    update_gig_call_time()
    update_gig_start_time()
    update_gig_end_time()

  $("input#gig_end_date_display").change ->
    update_gig_end_time()

  $("input#gig_call_time_display").change ->
    update_gig_call_time()

  $("input#gig_start_time_display").change ->
    update_gig_start_time()

  $("input#gig_end_time_display").change ->
    update_gig_end_time()

  $("input#gig_confirmation_deadline_display").change ->
    update_deadline()
