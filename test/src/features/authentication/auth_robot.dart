import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_to_do/src/common_widgets/primary_button.dart';
import 'package:super_to_do/src/features/authentication/data/auth_repository.dart';
import 'package:super_to_do/src/features/authentication/presentation/email_password_sign_in_form_type.dart';
import 'package:super_to_do/src/features/authentication/presentation/email_password_sign_in_screen.dart';

class AuthRobot {
  AuthRobot(this.tester);
  final WidgetTester tester;

  Future<void> pumpEmailPasswordSignInContents({
    required AuthRepository authRepository,
    required EmailPasswordSignInFormType formType,
    VoidCallback? onSignedIn,
  }) async {
    return tester.pumpWidget(
      ProviderScope(
        overrides: [authRepositoryProvider.overrideWithValue(authRepository)],
        child: MaterialApp(
          home: Scaffold(
            body: EmailPasswordSignInContents(
              formType: formType,
              onSignedIn: onSignedIn,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> tapEmailAndPasswordSubmitButton() async {
    final primaryButton = find.byType(PrimaryButton);
    expect(primaryButton, findsOneWidget);
    await tester.tap(primaryButton);
    await tester.pumpAndSettle();
  }
}
