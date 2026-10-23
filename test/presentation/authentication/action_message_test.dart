import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tsi_ind_pr_2/presentation/shared/helpers/action_message.dart';

void main() {
  testWidgets('rapid messages show the latest without a backlog', (tester) async {
    late BuildContext messageContext;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              messageContext = context;
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );

    showActionMessage(messageContext, 'First');
    await tester.pumpAndSettle();
    for (var i = 0; i < 10; i++) {
      showActionMessage(messageContext, 'Message $i');
    }
    await tester.pumpAndSettle();
    expect(find.text('Message 9'), findsOneWidget);
    expect(find.text('First'), findsNothing);

    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
    expect(find.byType(SnackBar), findsNothing);
  });
}
