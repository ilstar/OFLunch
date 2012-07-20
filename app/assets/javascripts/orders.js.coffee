# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  updateOrderItem = (menuItemId, name, price, count) ->
    if count is 0
      $("#order_item_#{menuItemId}").remove()
      return

    price = parseInt price
    count = parseInt count
    str = """
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
    if $('#order_form ul').find("#order_item_#{menuItemId}").length is 0
      $('#order_form ul').append $("<li id='order_item_#{menuItemId}' data-menu-id='#{menuItemId}'>#{str}</li>")
    else
      $('#order_form ul').find("#order_item_#{menuItemId}").html str
    return

  $("ul#menu_items li").click ->
    $name = $(this).find "span.name"
    $price = $(this).find "span.price"
    $count = $(this).find "span.count"

    if $count.html() is "&nbsp;"
      $count.html 1
    else
      $count.html parseInt($count.html()) + 1

    updateOrderItem $(this).data('menu-id'), $name.html(), $price.html(), $count.html()
    $('#order_form_wrapper').show() if $('#order_items').children().length > 0

  $('ul#order_items li a').live 'click', ->
    $li = $(this).parent().parent()
    $name = $($li).find "span.name"
    $price = $($li).find "span.price"
    $count = $($li).find "span.count"
    menuItemId = $($li).data 'menu-id'
    newCount = parseInt($count.html()) - 1
    updateOrderItem menuItemId, $name.html(), $price.html(), newCount

    if newCount is 0
      $("#menu_item_#{menuItemId} span.count").html "&nbsp;"
    else
      $("#menu_item_#{menuItemId} span.count").html newCount

    $('#order_form_wrapper').hide() if $('#order_items').children().length is 0

    return

