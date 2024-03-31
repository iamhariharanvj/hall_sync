import 'package:hall_sync/features/domain/entities/slot_entity.dart';
import 'package:hall_sync/features/domain/repositories/slot_repository.dart';

class GetUserSlotsUsecase {
  final SlotRepository repository;

  GetUserSlotsUsecase({required this.repository});

  Stream<List<SlotEntity>> call(String uid){
    return repository.getUserSlots(uid);
  }
}