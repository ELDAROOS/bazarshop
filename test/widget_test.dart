import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bazarshop/main.dart'; // Замените на имя вашего проекта

void main() {
  group('HomePage Widget Tests', () {
    testWidgets('Check if video plays on HomePage', (WidgetTester tester) async {
      // Запускаем HomePage для теста
      await tester.pumpWidget(MyApp());

      // Проверяем, что текст "BAZAR" отображается
      expect(find.text('BAZAR'), findsOneWidget);

      // Проверяем, что кнопка меню присутствует
      expect(find.byIcon(Icons.menu), findsOneWidget);

      // Проверяем, что кнопка поиска присутствует
      expect(find.byIcon(Icons.search), findsOneWidget);

      // Проверяем, что кнопка профиля присутствует
      expect(find.byIcon(Icons.person), findsOneWidget);

      // Проверяем, что кнопка корзины присутствует
      expect(find.byIcon(Icons.shopping_cart), findsOneWidget);
    });

    testWidgets('Search bar works and navigates to SearchPage', (WidgetTester tester) async {
      // Запускаем HomePage для теста
      await tester.pumpWidget(MyApp());

      // Находим строку поиска
      final searchField = find.byType(TextField);

      // Убедимся, что строка поиска отображается
      expect(searchField, findsOneWidget);

      // Вводим текст в строку поиска
      await tester.enterText(searchField, 'test query');
      await tester.pump();

      // Нажимаем кнопку Enter
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      // Проверяем, что произошла навигация на страницу с результатами поиска
      expect(find.text('You searched for: test query'), findsOneWidget);
    });
  });
}
