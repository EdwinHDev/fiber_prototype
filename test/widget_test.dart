// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fiber_prototype/main.dart';
import 'package:fiber_prototype/features/infrastructure/data/local/app_database.dart';
import 'package:fiber_prototype/features/infrastructure/presentation/providers/infrastructure_providers.dart';

void main() {
  testWidgets('Map screen smoke test', (WidgetTester tester) async {
    final database = AppDatabase();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(database)],
        child: const FiberApp(),
      ),
    );

    expect(find.byType(Scaffold), findsOneWidget);
  });
}
