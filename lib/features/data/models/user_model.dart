import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hall_sync/features/domain/entities/user_entity.dart';

class UserModel extends UserEntity{
  const UserModel({
    String? uid,
    String? name,
    String? type,
    String? email,
    String? password,
    String? profileUrl,
  }):super(uid: uid, name: name, type: type, email: email, password: password, profileUrl: profileUrl);

  factory UserModel.fromDocument(DocumentSnapshot documentSnapshot){
    return UserModel(
      uid: documentSnapshot.get('uid'),
      name: documentSnapshot.get('name'),
      type: documentSnapshot.get('type'),
      email: documentSnapshot.get('email'),
      profileUrl: documentSnapshot.get('profileUrl'),
    );
  }

  Map<String, dynamic> toDocument(){
    return {
      "uid": uid,
      "name": name,
      "type": type,
      "email": email,
      "profileUrl": profileUrl
    };
  }
}