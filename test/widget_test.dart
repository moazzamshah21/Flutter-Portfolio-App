import 'package:flutter_test/flutter_test.dart';
import 'package:mockapp/main.dart';

void main() {
  testWidgets('Portfolio app loads splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(const PortfolioApp());
    expect(find.text('Moazzam Shah Khan'), findsOneWidget);
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
  });
}
