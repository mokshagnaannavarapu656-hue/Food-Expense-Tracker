import 'package:flutter_test/flutter_test.dart';
import 'package:food_expense_tracker/main.dart';
void main() {
  testWidgets('FoodSpend dashboard starts', (tester) async {
    await tester.pumpWidget(const FoodSpendApp());
    await tester.pumpAndSettle();
    expect(find.text('FoodSpend'), findsOneWidget);
    expect(find.text('Food expense history'), findsOneWidget);
  });
}
