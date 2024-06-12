import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  //get collection of messages
  final CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  String user = "user";
  // CREATE: add message
  Future<void> addMessage(Map<String, String> message) {
    return messages.add({'message': message, 'timestamp': Timestamp.now()});
  }

  Stream<QuerySnapshot> getMessagesStream() {
    final messagesStream =
        messages.orderBy('timestamp', descending: true).snapshots();
    return messagesStream;
  }

  void changeUser(String user) {
    this.user = user;
  }
}
