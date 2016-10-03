$(document).on 'turbolinks:load', ->

  $('.datepicker').pickadate( format: 'mmm d, yyyy')
  $('.timepicker').pickatime( interval: 15, format: 'h:iA')
  
