import 'package:flutter_test/flutter_test.dart';
import 'package:w40k_army_opti/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const W40kCollectionApp());
    expect(find.text('W40K Collection Manager'), findsOneWidget);
  });
}
