import 'package:flutter/cupertino.dart';
import 'package:sfbms_mobile/data/models/cart_item.dart';

class CartViewModel extends ChangeNotifier {
  final Map<String, CartItem> _items = {};
  final Map<String, CartItem> _hoveringItems =
      {}; // slots which user selected but hadn't add to cart

  Map<String, CartItem> get items => {..._items};
  Map<String, CartItem> get hoveringItems => {..._hoveringItems};

  int get itemCount => _items.length;

  void addItems() {
    hoveringItems.forEach((cartItemId, cartItem) {
      _items.putIfAbsent(cartItemId, () => cartItem);
    });
    notifyListeners();
  }

  void removeItem({required String cartItemId}) {
    _items.remove(cartItemId);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  bool containsItem({required int id, required String startTime}) {
    var cartItemId = "${id}_$startTime";
    return _items.containsKey(cartItemId);
  }

  void addHoveringItem({
    required int id,
    required int fieldId,
    required String fieldName,
    required String startTime,
    required String endTime,
    required int slotNumber,
  }) {
    var cartItemId =
        "${id}_$startTime"; // to prevent user from booking the same slot & date more than once
    _hoveringItems.putIfAbsent(
      cartItemId,
      () => CartItem(
        cartItemId: cartItemId,
        id: id,
        fieldId: fieldId,
        fieldName: fieldName,
        startTime: startTime,
        endTime: endTime,
        slotNumber: slotNumber,
      ),
    );
    notifyListeners();
  }

  void removeHoveringItem({required int id, required String startTime}) {
    var cartItemId = "${id}_$startTime";
    _hoveringItems.remove(cartItemId);
    notifyListeners();
  }

  void clearHovering() {
    _hoveringItems.clear();
    notifyListeners();
  }
}
