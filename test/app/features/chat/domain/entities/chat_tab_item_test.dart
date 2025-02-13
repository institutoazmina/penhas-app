import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_tab_item.dart';

void main() {
  group(ChatTabItem, () {
    test('people title is correct', () {
      expect(ChatTabItem.people.title, 'Todas as usuárias');
    });

    test('talks title is correct', () {
      expect(ChatTabItem.talks.title, 'Conversas');
    });
  });
}
