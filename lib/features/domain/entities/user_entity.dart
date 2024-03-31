import 'package:equatable/equatable.dart';

class UserEntity extends Equatable{
  final String? uid;
  final String? name;
  final String? type;
  final String? email;
  final String? password;
  final String? profileUrl;

  const UserEntity({this.uid, this.name, this.type, this.email, this.password, this.profileUrl});
  
  @override
  List<Object?> get props{
    return [uid, name, type, email, password, profileUrl];
  }

}