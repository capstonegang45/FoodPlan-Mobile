import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_plan/pages/login_or_register.dart'; // Ganti dengan nama package Anda

void main() {
  testWidgets('LoginOrRegister displays title and description', (WidgetTester tester) async {
    // Build the LoginOrRegister widget
    await tester.pumpWidget(const MaterialApp(home: LoginOrRegister()));

    // Verify that the title is displayed
    expect(find.text('FOODPLAN'), findsOneWidget);
    expect(find.text('Temukan resep sehat, rencana diet, dan saran dari AI kami untuk mencapai tujuan dietmu. Mulai sekarang!'), findsOneWidget);
  });

  testWidgets('LoginOrRegister displays buttons', (WidgetTester tester) async {
    // Build the LoginOrRegister widget
    await tester.pumpWidget(const MaterialApp(home: LoginOrRegister()));

    // Verify that the buttons are displayed
    expect(find.text('MASUK'), findsOneWidget);
    expect(find.text('DAFTAR'), findsOneWidget);
  });

  testWidgets('Tapping on MASUK navigates to login page', (WidgetTester tester) async {
    // Build the LoginOrRegister widget
    await tester.pumpWidget(MaterialApp(
      home: const LoginOrRegister(),
      routes: {
        '/login': (context) => const Scaffold(body: Center(child: Text('Login Page'))),
      },
    ));

    // Tap on the 'MASUK' button
    await tester.tap(find.text('MASUK'));
    await tester.pumpAndSettle(); // Wait for the navigation to complete

    // Verify that the navigation to the login page occurs
    expect(find.text('Login Page'), findsOneWidget);
  });

  testWidgets('Tapping on DAFTAR navigates to register page', (WidgetTester tester) async {
    // Build the LoginOrRegister widget
    await tester.pumpWidget(MaterialApp(
      home: const LoginOrRegister(),
      routes: {
        '/register': (context) => const Scaffold(body: Center(child: Text('Register Page'))),
      },
    ));

    // Tap on the 'DAFTAR' button
    await tester.tap(find.text('DAFTAR'));
    await tester.pumpAndSettle(); // Wait for the navigation to complete

    // Verify that the navigation to the register page occurs
    expect(find.text('Register Page'), findsOneWidget);
  });

 
}