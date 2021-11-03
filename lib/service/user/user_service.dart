import 'package:firebase_auth/firebase_auth.dart';
import 'package:rock_chat/model/user.dart' as Model;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rock_chat/util/util.dart';

class UserService {
  static final CollectionReference _ref =
      FirebaseFirestore.instance.collection('user');

  static Future<void> saveUser(Model.User user) async {
    // String docId = _ref.doc().id; // used auth.uid, idk if its bad idea to expose in api
    await _ref.doc(user.id).set(user.toJson());
  }

  static Stream<List<Model.User>> getUsers() {
    return _ref
        .where('id', isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .transform(Utils.transformer(Model.User.fromJson));
  }
}
