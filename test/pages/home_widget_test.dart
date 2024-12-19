import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_plan/pages/home_page.dart';

void main() {
  testWidgets('HomePage renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomePage()));

   // Check if the AppBar is present
    expect(find.byType(AppBar), findsOneWidget);
  });
  testWidgets('HomePage renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    // Check if the bottom navigation bar is present
    expect(find.byType(BottomNavigationBar), findsOneWidget);

  });
}