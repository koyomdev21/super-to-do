import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:super_to_do/src/features/authentication/presentation/email_password_sign_in_form_type.dart';

import '../../../../mocks.dart';
import '../auth_robot.dart';

void main() {
  const tEmail = 'test@test.com';
  const tPassword = 'password';
  late MockAuthRepository authRepository;
  setUp(() {
    authRepository = MockAuthRepository();
  });
  group('emailPasswordSignInScreen sign in', () {
    testWidgets('''
Given formType is signIn
When tap on the sign-in button
Then signInWithEmailAndPassword is not called
''', (tester) async {
      final r = AuthRobot(tester);
      await r.pumpEmailPasswordSignInContents(
        authRepository: authRepository,
        formType: EmailPasswordSignInFormType.signIn,
      );
      await r.tapEmailAndPasswordSubmitButton();
      verifyNever(
        () => authRepository.signInWithEmailAndPassword(
          any(),
          any(),
        ),
      );
    });
  });
}
