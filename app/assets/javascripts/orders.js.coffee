# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# listen click event on left nav of /orders/new page.

app = angular.module "OrdersApp", ['ngResource']

app.controller "OrdersCtrl", ($scope, $resource) ->
  Order = $resource "/orders/today.json", {}, {
    "today": {method: 'GET', isArray: true}
  }
  MenuItem = $resource "/menu_items/today.json", {}, {
    "today": {method: 'GET', isArray: true}
  }
  $scope.order_items = []

  $scope.order_items = Order.today()
  $scope.menus = MenuItem.today()

  $scope.isOrderItemsEmpty = ->
    $scope.order_items.length is 0

  $scope.addOrderItem = (menu_item) ->
    item = order_item for order_item in $scope.order_items when order_item.id is menu_item.id

    if item is undefined
      $scope.order_items.push {id: menu_item.id, name: menu_item.name, price: menu_item.price, count: 1}
    else
      item.count++

  $scope.removeOrderItem = (orderItem) ->
    [item, index] = [order_item, i] for i, order_item of $scope.order_items when order_item.id is orderItem.id

    if item.count is 1
      $scope.order_items.splice index, 1
    else
      item.count--

  $scope.orderItemsCount = (menuItemId) ->
    item = order_item for order_item in $scope.order_items when order_item.id is menuItemId

    if item is undefined then null else item.count

  $scope.totalPrice = ->
    n = 0
    n += item.count * item.price for item in $scope.order_items
    n



$("body").on 'click', "#quick-nav li", ->
  $target = $("##{$(this).data 'target'}")
  $("body").animate {scrollTop: $target.offset().top - 41}, 250
