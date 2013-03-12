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

//= require angular.min
//= require orders2

jQuery ->
  jQuery('.best_in_place').best_in_place()

  $('#unread-message-count').click ->
    $('#unread-message-content').toggle('drop', {direction: 'right'}, 270)

  $('#change_user_list').on 'show', ->
    $("#change_user_form").load("/sessions")

  $('#switch_account_bar').draggable({cursor: 'move'})

  # patch
  # with twitter-bootstrap-rails 2.1.3, the link of sign out in nav bar can't request server with delete method.
  $('body')
    .off('click.dropdown touchstart.dropdown.data-api', '.dropdown')
    .on('click.dropdown touchstart.dropdown.data-api', '.dropdown form', (e) -> e.stopPropagation() )

  return
