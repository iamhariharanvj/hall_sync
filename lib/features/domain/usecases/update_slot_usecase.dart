import 'package:hall_sync/features/domain/entities/slot_entity.dart';
import 'package:hall_sync/features/domain/repositories/slot_repository.dart';

class UpdateSlotUsecase{
  final SlotRepository repository;

  UpdateSlotUsecase({required this.repository});

  Future<void> call(SlotEntity slot){
    return repository.updateSlot(slot);
  }
}