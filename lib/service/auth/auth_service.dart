import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rock_chat/service/auth/auth_state.dart';
import 'package:rock_chat/service/user/user_creation_service.dart';
import 'package:rock_chat/model/user.dart' as Model;

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<Model.User?> get userAuthStateChanges {
    return _firebaseAuth.authStateChanges().asyncMap((firebaseUser) async {
      if (firebaseUser == null) {
        return null;
      }
      final snapshot = await FirebaseFirestore.instance
          .collection('user')
          .doc(firebaseUser.uid)
          .get();
      return Model.User(
          id: firebaseUser.uid,
          email: firebaseUser.email!,
          username: snapshot.data()!['username'],
          firstName: snapshot.data()!['first_name'],
          lastName: snapshot.data()!['last_name'],
          chatIconColor: snapshot.data()!['chat_icon_color'],
          chatAbbreviation: snapshot.data()!['chat_abbreviation']);
    });
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<AuthenticationState> signIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return AuthenticationState(AuthenticationStatus.authed, null);
    } on FirebaseAuthException catch (e) {
      return AuthenticationState(AuthenticationStatus.error, e.message);
    }
  }

  Future<AuthenticationState> signUp(
      {required String email,
      required String firstName,
      required String lastName,
      required String password}) async {
    try {
      final newUser = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await UserCreaionService.createUser(
          newUser.user!.uid, email, firstName, lastName);
      return AuthenticationState(AuthenticationStatus.authed, null);
    } on FirebaseAuthException catch (e) {
      return AuthenticationState(AuthenticationStatus.error, e.message);
    }
  }
}
