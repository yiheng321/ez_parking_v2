import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

final tUser = MockUser(
  isAnonymous: false,
  email: 'test@gmail.com',
  displayName: 'testGmail',
);

void main() {
  test('Returns no user if not signed in', () async {
    final auth = MockFirebaseAuth();
    final user = auth.currentUser;
    expect(user, isNull);
  });

  group('Returns a mocked user user after sign in', ()
  {
    test('with Credential', () async {
      final auth = MockFirebaseAuth(mockUser: tUser);
      // Credentials would typically come from GoogleSignIn.
      final credential = FakeAuthCredential();
      final result = await auth.signInWithCredential(credential);
      final user = await result.user;
      expect(user, tUser);
      expect(auth.authStateChanges(), emitsInOrder([isA<User>()]));
      expect(user.isAnonymous, isFalse);
    });

    test('with email and password', () async {
      final auth = MockFirebaseAuth(mockUser: tUser);
      final result =
      await auth.signInWithEmailAndPassword(
          email: 'some email', password: 'some password');
      final user = await result.user;
      expect(user, tUser);
      expect(auth.authStateChanges(), emitsInOrder([isA<User>()]));
    });


    test('Returns a mocked user if already signed in', () async {
      final auth = MockFirebaseAuth(signedIn: true, mockUser: tUser);
      final user = auth.currentUser;
      expect(user, tUser);
    });
  });

}

class FakeAuthCredential extends Mock implements AuthCredential {}
