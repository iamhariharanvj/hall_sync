import 'package:hall_sync/features/domain/entities/user_entity.dart';
import 'package:hall_sync/features/domain/repositories/user_repository.dart';

class GetCreateCurrentUserUsecase {

  final UserRepository repository;

  GetCreateCurrentUserUsecase({required this.repository});

  Future<void> call(UserEntity user)async{
    return repository.getCreateCurrentUser(user);
  }
}