import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:wdb106_sample/model/model.dart';

void main() {
  test('ItemStock.fromJSON test', () async {
    const source = '''
    {
      "id": 100,
      "price": 200,
      "title": "test",
      "imageUrl": "https://mono0926.com/images/love_logo.png",
      "quantity": 5
    }
    ''';

    final json = jsonDecode(source);
    final target = ItemStock.fromJSON(json as Map<String, dynamic>);
    final item = target.item;
    expect(item.id, 100);
    expect(item.price, 200);
    expect(item.title, 'test');
    expect(item.imageUrl, 'https://mono0926.com/images/love_logo.png');
    expect(target.quantity, 5);
  });
}
