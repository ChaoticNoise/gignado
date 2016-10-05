$(document).on 'turbolinks:load', ->

  # Init date and time displays in edit form
  if $("form.edit_rehearsal").length > 0
    start_time = new Date($("input#rehearsal_start_time").val())
    end_time = new Date($("input#rehearsal_end_time").val())
    $("input#rehearsal_date").val(strftime("%b %e, %Y", start_time))
    $("input#rehearsal_start_time_display").val(strftime("%l:%M %p", start_time))
    $("input#rehearsal_end_time_display").val(strftime("%l:%M %p", end_time))

  update_rehearsal_start_time = ->
    date = $("input#rehearsal_date").val()
    time = $("input#rehearsal_start_time_display").val()
    $("input#rehearsal_start_time").val(new Date("#{date} #{time}").toISOString())

  update_rehearsal_end_time = ->
    date = $("input#rehearsal_date").val()
    time = $("input#rehearsal_end_time_display").val()
    $("input#rehearsal_end_time").val(new Date("#{date} #{time}").toISOString())

  $("input#rehearsal_date").change ->
    update_rehearsal_start_time()
    update_rehearsal_end_time()

  $("input#rehearsal_start_time_display").change ->
    update_rehearsal_start_time()

  $("input#rehearsal_end_time_display").change ->
    update_rehearsal_end_time()
