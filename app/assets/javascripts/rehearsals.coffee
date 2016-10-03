$(document).on 'turbolinks:load', ->

  update_rehearsal_start_time = ->
    date = $("input#rehearsal_date").value()
    time = $("input#rehearsal_start_time_display")
    $("input#rehearsal_start_time").value("#{date} #{rehearsal_start_time_display}")

  update_rehearsal_end_time = ->
    date = $("input#rehearsal_date").value()
    time = $("input#rehearsal_end_time_display")
    $("input#rehearsal_end_time").value("#{date} #{rehearsal_end_time_display}")

  $("input#rehearsal_date").change ->
    update_rehearsal_start_time()
    update_rehearsal_end_time()

  $("input#rehearsal_start_time_display").change ->
    update_rehearsal_start_time()

  $("input#rehearsal_end_time_display").change ->
    update_rehearsal_end_time()
