//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require jquery.scrollTo-min
//= require jquery.purr
//= require best_in_place

jQuery ->
  jQuery('.best_in_place').best_in_place();
  $("#calendar span[rel=tooltip]").tooltip
    title: "充值记录"
    placement: "right"
  $("#calendar span[rel=popover]").popover()