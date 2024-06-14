import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

/// [FirestorService] est une classe qui implémente des méthodes fournis par 
/// Firebase pour le stockage des utilisateurs et les messages. 
class FirestoreService {
  //get collection of messages
  final CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  // CREATE: add message
  Future<void> addMessage(String user, Map<String, String> message) {
    return messages
        .add({'user': user, 'message': message, 'timestamp': Timestamp.now()});
  }

  // READ: get all messages ordered by timestamp
  Stream<QuerySnapshot> getMessagesStream() {
    return messages.orderBy('timestamp', descending: true).snapshots();
  }

  // READ: get messages for a specific user
  Stream<QuerySnapshot> getUserMessagesStream(String userId) {
    return messages
        .where('user', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
  void afficher() async{
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('messages').get();
      for (var document in querySnapshot.docs) {
        print(document.data());
      }
  }
  


  

}
