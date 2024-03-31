import 'package:hall_sync/features/domain/repositories/user_repository.dart';

class GetCurrentUIdUsecase{

  final UserRepository repository;
  
  GetCurrentUIdUsecase({required this.repository});

  Future<String> call(){
    return repository.getCurrentUId();
  }
}