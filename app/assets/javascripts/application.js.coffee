//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require jquery.scrollTo-min
//= require jquery.purr
//= require best_in_place
//= require jquery.effects.drop

jQuery ->
  jQuery('.best_in_place').best_in_place()

  $("#calendar span[rel=tooltip]").tooltip
    title: "充值记录"
    placement: "right"
  $("#calendar span[rel=popover]").popover()

  $('#unread-message-count').click ->
    $('#unread-message-content').toggle('drop', {direction: 'right'}, 270)
  return
