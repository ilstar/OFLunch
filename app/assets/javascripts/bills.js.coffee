# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $("span[rel=tooltip]").tooltip
    title: "充值记录"
    placement: "right"
  $("span[rel=popover]").popover()