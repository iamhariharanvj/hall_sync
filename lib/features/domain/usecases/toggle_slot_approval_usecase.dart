import 'package:hall_sync/features/domain/entities/slot_entity.dart';
import 'package:hall_sync/features/domain/repositories/slot_repository.dart';

class ToggleSlotApprovalUsecase{
  final SlotRepository repository;

  ToggleSlotApprovalUsecase({required this.repository});

  Future<void> call(SlotEntity slot){
    return repository.toggleSlotApproval(slot);
  }
}