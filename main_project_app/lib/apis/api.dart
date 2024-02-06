import "package:firebase_core/firebase_core.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class APIs {
  // the following are the objects made

  // for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;

  // for accessing cloud firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  // for checking if user exits or not?
  // do the write operation only if the user is new or else dont overwrite the existing data
  static Future<bool> userExits() async {
    return (await firestore
            .collection('Users')
            .doc(auth.currentUser!
                .uid) // using the uid from the gmail login from firestore as the document id
            .get())
        .exists;
  }
}
