# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  updateTotalCost = ->
    total_cost = 0
    $('#order_items li').each ->
      total_cost += parseInt($("span.count", this).html()) * parseFloat($("span.price", this).html())
    $("#total_cost span").html total_cost

  updateOrderItem = (menuItemId, name, price, count) ->
    $orderItem = $("#order_item_#{menuItemId}")

    if count is 0
      $orderItem.remove()
    else
      price = parseFloat price
      count = parseInt count
      orderItemHtml = """
        <span class='name'>#{name}</span>
        <span class='right'>
          <span class='price'>#{price}</span>
          <span class="multiply">x</span>
          <span class='count'>#{count}</span>
          <a href="javascript:;" class="delete"><i class="icon-minus-sign icon-white"></i></a>
          <input name='order[order_items_attributes][][menu_item_id]' type='hidden' value='#{menuItemId}'>
          <input name='order[order_items_attributes][][price]' type='hidden' value='#{price}'>
          <input name='order[order_items_attributes][][amount]' type='hidden' value='#{count}'>
        </span>
      """
      if $orderItem.length is 0
        $('#order_form ul').append $("<li id='order_item_#{menuItemId}' data-menu-id='#{menuItemId}'>#{orderItemHtml}</li>")
      else
        $orderItem.html orderItemHtml

    updateTotalCost()

  $("ul#menu_items li").click ->
    name = $("span.name", this).html()
    price = $("span.price", this).html()
    $count = $(this).find "span.count"

    if $count.html() is "&nbsp;"
      $count.html 1
    else
      $count.html parseInt($count.html()) + 1

    updateOrderItem $(this).data('menu-id'), name, price, $count.html()

    $('#order_form_wrapper').show() if $('#order_items').children().length > 0

  $('ul#order_items li a.delete').live 'click', ->
    $orderItem = $(this).parent().parent()
    name = $("span.name", $orderItem).html()
    price = $("span.price", $orderItem).html()
    $count = $("span.count", $orderItem)
    menuItemId = $orderItem.data 'menu-id'
    newCount = parseInt($count.html()) - 1

    updateOrderItem menuItemId, name, price, newCount
    $("#menu_item_#{menuItemId} span.count").html if newCount is 0 then "&nbsp;" else newCount
    $('#order_form_wrapper').hide() if $('#order_items').children().length is 0

