$(document).on 'turbolinks:load', ->

  $('.datepicker').pickadate()
  $('.timepicker').pickatime( interval: 15)
