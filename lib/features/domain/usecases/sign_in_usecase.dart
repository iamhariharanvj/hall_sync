import 'package:hall_sync/features/domain/entities/user_entity.dart';
import 'package:hall_sync/features/domain/repositories/user_repository.dart';

class SignInUsecase{
  final UserRepository repository;

  SignInUsecase({required this.repository});

  Future<void> call(UserEntity user){
    return repository.login(user);
  }
}