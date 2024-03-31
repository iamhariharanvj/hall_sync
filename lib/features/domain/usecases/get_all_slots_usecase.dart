import 'package:hall_sync/features/domain/entities/slot_entity.dart';
import 'package:hall_sync/features/domain/repositories/slot_repository.dart';

class GetAllSlotsUsecase {
  final SlotRepository repository;

  GetAllSlotsUsecase({required this.repository});

  Stream<List<SlotEntity>> call(){
    return repository.getAllSlots();
  }
}