function OrderCtrl($scope, $http) {
  $scope.order_items = [];
  $http.get("/orders/new.json").success(function(data) {
    $scope.menus = data.menu_items;
    $scope.order_items = data.order_items;
  })


  $scope.orderItemsEmpty = function() {
    return $scope.order_items.length == 0;
  }

  $scope.addOrderItem = function(menu_item) {
    var item = null;
    for (var i = $scope.order_items.length - 1; i >= 0; i--) {
      if ($scope.order_items[i].id == menu_item.id) {
        item = $scope.order_items[i];
      };
    };

    if (item == null) {
      var order_item = {id: menu_item.id, name: menu_item.name, price: menu_item.price, count: 1}
      $scope.order_items.push(order_item);
    } else {
      item.count++;
    }
  }

  $scope.removeOrderItem = function(orderItem) {
    var item = null;
    var index = 0;
    for (var i = $scope.order_items.length - 1; i >= 0; i--) {
      if ($scope.order_items[i].id == orderItem.id) {
        item = $scope.order_items[i];
      };
    };
    if (item.count == 1) {
      $scope.order_items.splice(index, 1);
    } else {
      item.count--;
    }
  }

  $scope.orderItemsCount = function(menuItemId) {
    var item = null;
    for (var i = $scope.order_items.length - 1; i >= 0; i--) {
      if ($scope.order_items[i].id == menuItemId) {
        item = $scope.order_items[i];
      }
    }

    return item == null ? null : item.count;
  }

  $scope.totalPrice = function() {
    var n = 0;
    for (var i = $scope.order_items.length - 1; i >= 0; i--) {
      var item = $scope.order_items[i];
      n += item.count * item.price;
    };

    return n;
  }
}