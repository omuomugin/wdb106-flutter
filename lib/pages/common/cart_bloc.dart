import '../../model/model.dart';

@immutable
class CartSummary {
  final int quantity;
  final int totalPrice;
  String get state => 'カート($quantity)';
  String get totalPriceState => '合計金額 $totalPrice円+税';

  const CartSummary({
    @required this.quantity,
    @required this.totalPrice,
  });

  static const zero = CartSummary(quantity: 0, totalPrice: 0);

  @override
  String toString() {
    return 'CartSummary{quantity: $quantity, totalPrice: $totalPrice}';
  }
}

class CartBloc implements Bloc {
  final CartStore _cartStore;
  final _deletionController = PublishSubject<Item>();
  final ValueObservable<CartSummary> _cartSummary;

  CartBloc({@required CartStore cartStore})
      : _cartStore = cartStore,
        _cartSummary = cartStore.items.map<CartSummary>((items) {
          final totalQuantity =
              items.fold<int>(0, (sum, e) => sum + e.quantity);
          final totalPrice =
              items.fold<int>(0, (sum, e) => sum + e.item.price * e.quantity);
          return CartSummary(
            quantity: totalQuantity,
            totalPrice: totalPrice,
          );
        }).shareValue(seedValue: CartSummary.zero) {
    _deletionController.listen(_cartStore.delete);
  }

  ValueObservable<CartSummary> get cartSummary => _cartSummary;
  ValueObservable<List<CartItem>> get cartItems => _cartStore.items;
  Sink<Item> get deletion => _deletionController.sink;

  @override
  void dispose() {
    _deletionController.close();
  }
}
