import 'package:hall_sync/features/domain/repositories/user_repository.dart';

class IsSignInUsecase{
  final UserRepository repository;

  IsSignInUsecase({required this.repository});

  Future<bool> call(){
    return repository.isSignedIn();
  }

}