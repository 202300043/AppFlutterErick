import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('Muestra la pantalla de inicio de sesión', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Iniciar sesión'), findsOneWidget);
    expect(find.text('Iniciar Sesión'), findsOneWidget);
    expect(find.text('Crear una cuenta'), findsOneWidget);
  });
}
