$(document).on 'turbolinks:load', ->
  # Check query boxes from cookie
  if $("form#new_member_query input").length
    checkbox_ids = eval(Cookies.get('new_member_query'))
    if checkbox_ids? and checkbox_ids.length > 0
      $("input:checkbox").prop('checked', false)
      $(checkbox_ids).each (i, id) ->
        $("input:checkbox##{id}").prop('checked', true)
      $("form#new_member_query").submit()

  # Handle query checkboxes
  $("form#new_member_query input").change (e) ->
    checkbox_ids = $("input:checkbox:checked").map ->
      $(@).attr('id')
    Cookies.set('new_member_query', checkbox_ids.get())
    $("form#new_member_query").submit()
