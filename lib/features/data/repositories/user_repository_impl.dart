import 'package:hall_sync/features/data/data_sources/remote/firebase_remote_data_source.dart';
import 'package:hall_sync/features/domain/entities/user_entity.dart';
import 'package:hall_sync/features/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final FirebaseRemoteDataStore remoteDataSource;
  UserRepositoryImpl({required this.remoteDataSource});
  
  @override
  Future<void> getCreateCurrentUser(UserEntity user) async =>
    remoteDataSource.getCreateCurrentUser(user);
  
  @override
  Future<String> getRole(String uid) async => 
    remoteDataSource.getRole(uid);

  @override
  Future<String> getCurrentUId() async =>
    remoteDataSource.getCurrentUId();
  

  @override
  Future<bool> isSignedIn() =>
    remoteDataSource.isSignIn();
  

  @override
  Future<void> login(UserEntity user) =>
   remoteDataSource.signIn(user);
  

  @override
  Future<void> signOut() =>
    remoteDataSource.signOut();

  @override
  Future<void> signup(UserEntity user) =>
    remoteDataSource.signUp(user);
  
}
