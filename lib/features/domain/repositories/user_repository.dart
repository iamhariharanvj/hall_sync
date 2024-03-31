import 'package:hall_sync/features/domain/entities/user_entity.dart';

abstract class UserRepository{
  Future<void> login(UserEntity user);
  Future<void> signup(UserEntity user);
  Future<void> signOut();
  Future<bool> isSignedIn();
  Future<String> getRole(String uid);
  Future<String> getCurrentUId();
  Future<void> getCreateCurrentUser(UserEntity user);
}