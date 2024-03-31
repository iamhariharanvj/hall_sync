import 'package:hall_sync/features/domain/repositories/user_repository.dart';

class SignOutUsecase{
  final UserRepository repository;

  SignOutUsecase({required this.repository});

  Future<void> call(){
    return repository.signOut();
  }
}