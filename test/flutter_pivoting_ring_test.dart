import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pivoting_ring/flutter_pivoting_ring.dart';

void main() {
  testWidgets('PivotingRing widget should render', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(MaterialApp(home: PivotingRing()));

    // Verify if PivotingRing is rendered
    expect(find.byType(PivotingRing), findsOneWidget);
  });

  testWidgets('PivotingRing should animate', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(MaterialApp(home: PivotingRing()));

    // Check initial state
    final ringPainterFinder = find.byType(CustomPaint);
    CustomPaint customPaint =
        tester.firstWidget(ringPainterFinder) as CustomPaint;
    Ring3DPainter painter = customPaint.painter as Ring3DPainter;
    double initialValue = painter.animationValue;

    // Let the animation run for a bit
    await tester.pump(const Duration(seconds: 1));

    // Check updated state
    customPaint = tester.firstWidget(ringPainterFinder) as CustomPaint;
    painter = customPaint.painter as Ring3DPainter;
    double updatedValue = painter.animationValue;

    // Verify that the animation value has changed
    expect(updatedValue, isNot(equals(initialValue)));
  });
}
