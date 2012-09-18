//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require bootstrap
//= require jquery.purr
//= require best_in_place
//= require jquery.effects.drop
//= require jquery.ui.draggable

# rating
//= require jquery.rating.pack

//= require order_items
//= require bills

jQuery ->
  jQuery('.best_in_place').best_in_place()

  $('#unread-message-count').click ->
    $('#unread-message-content').toggle('drop', {direction: 'right'}, 270)

  $('#change_user_list').on 'show', ->
    $("#change_user_form").load("/sessions")

  $('#switch_account_bar').draggable({cursor: 'move'})
  return
