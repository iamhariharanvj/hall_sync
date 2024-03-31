import 'package:hall_sync/features/domain/entities/slot_entity.dart';

abstract class SlotRepository{
  Future<void> bookSlot(SlotEntity slot);
  Future<void> updateSlot(SlotEntity slot);
  Future<void> deleteSlot(SlotEntity slot);
  Future<void> toggleSlotApproval(SlotEntity slot);
  Stream<List<SlotEntity>> getUserSlots(String uid);
  Stream<List<SlotEntity>> getAllSlots();
  Stream<List<SlotEntity>> getApprovedSlots();
}