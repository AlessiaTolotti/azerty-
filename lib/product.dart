import 'package:flutter_riverpod/flutter_riverpod.dart';

class Product {
  final String id;
  final String name;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.price,
  });
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });
}

final productsProvider = Provider<List<Product>>((ref) {
  return [
    Product(id: '1', name: 'Maglietta', price: 19.99),
    Product(id: '2', name: 'Scarpe', price: 89.50),
    Product(id: '3', name: 'Cappello', price: 15.00),
   
  ];
});

class CartNotifier extends Notifier<List<CartItem>> {
  @override
  List<CartItem> build() {
    return [];
  }

  void addItem(Product p) {
    final index = state.indexWhere((item) => item.product.id == p.id);

    if (index >= 0) {
      state[index].quantity++;
      state = [...state];
    } else {
      state = [...state, CartItem(product: p)];
    }
  }

  void incrementItem(CartItem item) {
    item.quantity++;
    state = [...state];
  }

  void decrementItem(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      state.remove(item);
    }
    state = [...state];
  }
}

final cartProvider = NotifierProvider<CartNotifier, List<CartItem>>(() {
  return CartNotifier();
});