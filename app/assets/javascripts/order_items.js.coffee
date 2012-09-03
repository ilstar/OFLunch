# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('.rating').rating
    required: true
    callback: (value) ->
      $.ajax
        type: "PUT"
        url: "/order_items/#{$(this).parent().data('order_item_id')}/rating"
        data: {value: value}
        success: =>
          $(this).rating('disable')
        error: =>
          alert "something going wrong, please try again later."
