# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('.rating').rating
    required: true
    callback: (value) ->
      orderItemId = $(this).data('order-item-id')
      $.ajax
        type: "PUT"
        url: "/order_items/#{orderItemId}/rating"
        data: {value: value}
        success: =>
          $(this).rating('disable')
          $('#ratingForm').attr 'action', "/order_items/#{orderItemId}/comment"
          $('#ratingModal').modal('show')
        error: =>
          alert "something going wrong, please try again later."
