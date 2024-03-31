import 'package:hall_sync/features/domain/entities/user_entity.dart';
import 'package:hall_sync/features/domain/repositories/user_repository.dart';

class SignUpUsecase{
  final UserRepository repository;

  SignUpUsecase({required this.repository});

  Future<void> call(UserEntity user){
    return repository.signup(user);
  }
}