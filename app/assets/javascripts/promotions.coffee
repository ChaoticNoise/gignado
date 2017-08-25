# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->

  # Promotion Form
  $(".form-group.promotion_end_date_display").hide()

  $("input#promotion_multi_day").click ->
    $(".form-group.promotion_multi_day").hide()
    $(".form-group.promotion_end_date_display").show()

  update_promotion_start_time = ->
    start_date = $("input#promotion_start_date_display").val()
    start_time = $("input#promotion_start_time_display").val()
    $("input#promotion_start_time").val(new Date("#{start_date} #{start_time}").toISOString())

  update_promotion_end_time = ->
    start_date = $("input#promotion_start_date_display").val()
    end_date = $("input#promotion_end_date_display").val()
    end_date = if !!end_date then end_date else start_date
    end_time = $("input#promotion_end_time_display").val()
    $("input#promotion_end_time").val(new Date("#{end_date} #{end_time}").toISOString())

  update_promotion_time_display = ->
    start_time = new Date($("input#promotion_start_time").val())
    end_time = new Date($("input#promotion_end_time").val())
    start_date = strftime("%b %e, %Y", start_time)
    end_date = strftime("%b %e, %Y", end_time)


    if start_date != end_date
      if strftime("%b", start_time) != strftime("%b", end_time)
        begin = strftime("%b %o", start_time)
        end = strftime("%b %o", end_time)
        $("input#promotion_time_display").val("#{begin} - #{end}")
      else
        begin = strftime("%b %o", start_time)
        end = strftime("%o", end_time)
        $("input#promotion_time_display").val("#{begin} - #{end}")
    else
      time_display = strftime("%a, %b %o %l:%M %p", start_time)
      $("input#promotion_time_display").val(time_display)

  if $("form.edit_promotion, form.new_promotion").length > 0
    start_time = new Date($("input#promotion_start_time").val())
    end_time = new Date($("input#promotion_end_time").val())
    start_date = strftime("%b %e, %Y", start_time)
    end_date = strftime("%b %e, %Y", end_time)
    $("input#promotion_start_date_display").val(start_date)
    $("input#promotion_start_time_display").val(strftime("%l:%M %p", start_time))
    $("input#promotion_end_time_display").val(strftime("%l:%M %p", end_time))

    if start_date != end_date
      $("input#promotion_end_date_display").val(end_date)
      $(".form-group.promotion_multi_day").hide()
      $(".form-group.promotion_end_date_display").show()

    update_promotion_time_display()


  $("input#promotion_start_date_display").change ->
    update_promotion_start_time()
    update_promotion_end_time()
    update_promotion_time_display()

  $("input#promotion_end_date_display").change ->
    update_promotion_end_time()
    update_promotion_time_display()


  $("input#promotion_start_time_display").change ->
    update_promotion_start_time()
    update_promotion_time_display()

  $("input#promotion_end_time_display").change ->
    update_promotion_end_time()
    update_promotion_time_display()

