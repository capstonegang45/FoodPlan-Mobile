// test/login_screen_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_plan/pages/login.dart';

void main() {
  testWidgets('Login Screen Test', (WidgetTester tester) async {
    // Build the LoginScreen widget
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    // Verify that the login screen is displayed
    expect(find.text('Masuk'), findsOneWidget);
    expect(find.text('Masukkan email Anda'), findsOneWidget);
    expect(find.text('Masukkan kata sandi Anda'), findsOneWidget);
    expect(find.text('Lupa Password?'), findsOneWidget);
    expect(find.text('Daftar'), findsOneWidget);

    // Enter email and password
    await tester.enterText(find.byType(TextField).first, 'test@example.com');
    await tester.enterText(find.byType(TextField).last, 'password123');

    // Tap the login button
    await tester.tap(find.text('MASUK'));
    await tester.pump(); // Rebuild the widget after the state has changed

    // Verify that the error message is shown when fields are empty
    expect(find.text('Both fields are required.'), findsNothing);

    // You can add more tests to simulate successful login and error scenarios
  });
}