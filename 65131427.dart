class MenuItem {
  String name;
  double price;
  String category;

  MenuItem(this.name, this.price, this.category);
}

class Order {
  String orderId;
  int tableNumber;
  List<MenuItem> items = [];
  bool isCompleted = false;

  Order(this.orderId, this.tableNumber);

  void addItem(MenuItem item) {
    items.add(item);
  }

  void removeItem(MenuItem item) {
    items.remove(item);
  }

  void completeOrder() {
    isCompleted = true;
  }
}

class Restaurant {
  List<MenuItem> menu = [];
  List<Order> orders = [];
  Map<int, List<String>> tables = {};

  void addMenuItem(MenuItem item) {
    menu.add(item);
  }

  void removeMenuItem(MenuItem item) {
    menu.remove(item);
  }

  void placeOrder(Order order) {
    orders.add(order);
    if (!tables.containsKey(order.tableNumber)) {
      tables[order.tableNumber] = [];
    }
    tables[order.tableNumber]!.add(order.orderId);
  }

  void completeOrder(String orderId) {
    var order = getOrder(orderId);
    if (order != null) {
      order.completeOrder();
    }
  }

  MenuItem? getMenuItem(String name) {
    for (var item in menu) {
      if (item.name == name) {
        return item;
      }
    }
    return null;
  }

  Order? getOrder(String orderId) {
    for (var order in orders) {
      if (order.orderId == orderId) {
        return order;
      }
    }
    return null;
  }
}

void main() {
  var item1 = MenuItem("Noodles", 12.99, "อาหารคาว");
  var item2 = MenuItem("Cake", 4.99, "อาหารหวาน");
  var item3 = MenuItem("Thai tea", 1.99, "เครื่องดื่ม");

  var restaurant = Restaurant();

  restaurant.addMenuItem(item1);
  restaurant.addMenuItem(item2);
  restaurant.addMenuItem(item3);

  print("Menu:");
  for (var item in restaurant.menu) {
    print("${item.name} - \$${item.price} - ${item.category}");
  }

  var order1 = Order("1", 5);

  order1.addItem(item1);
  order1.addItem(item2);

  restaurant.placeOrder(order1);

  restaurant.completeOrder("1");

  print("\nOrder Status:");
  for (var order in restaurant.orders) {
    var status = order.isCompleted ? "Completed" : "Incomplete";
    print("Order ${order.orderId} - Table ${order.tableNumber} - Status: $status");
    for (var item in order.items) {
      print("  ${item.name} - \$${item.price}");
    }
  }
}
