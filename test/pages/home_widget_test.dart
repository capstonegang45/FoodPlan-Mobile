import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_plan/provider/users_providers.dart';
import 'package:provider/provider.dart';
import 'package:food_plan/pages/home_page.dart';

void main() {
  testWidgets('HomePage renders correctly', (WidgetTester tester) async {
    // Bungkus HomePage dengan Provider
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserProvider()),
        ],
        child: const MaterialApp(
          home: HomePage(),
        ),
      ),
    );

    // Verifikasi widget
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
  });
}
