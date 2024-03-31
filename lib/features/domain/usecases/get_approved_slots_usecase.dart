import 'package:hall_sync/features/domain/entities/slot_entity.dart';
import 'package:hall_sync/features/domain/repositories/slot_repository.dart';

class GetApprovedSlotsUsecase{
  final SlotRepository repository;

  GetApprovedSlotsUsecase({required this.repository});

  Stream<List<SlotEntity>> call(){
    return repository.getApprovedSlots();
  }
}