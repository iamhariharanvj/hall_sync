import 'package:hall_sync/features/domain/entities/slot_entity.dart';
import 'package:hall_sync/features/domain/repositories/slot_repository.dart';

class BookSlotUsecase{
  final SlotRepository repository;

  BookSlotUsecase({required this.repository});

  Future<void> call(SlotEntity slot){
    return repository.bookSlot(slot);
  }
}