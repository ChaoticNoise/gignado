$(document).on 'turbolinks:load', ->
  $("form#new_member_query input").change (e) ->
    $("form#new_member_query").submit()
