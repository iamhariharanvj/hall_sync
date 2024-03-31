import 'package:hall_sync/features/domain/repositories/user_repository.dart';

class GetRoleUsecase{

  final UserRepository repository;
  
  GetRoleUsecase({required this.repository});

  Future<String> call(String uid){
    return repository.getRole(uid);
  }
}