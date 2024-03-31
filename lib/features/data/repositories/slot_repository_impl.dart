import 'package:hall_sync/features/data/data_sources/remote/firebase_remote_data_source.dart';
import 'package:hall_sync/features/domain/entities/slot_entity.dart';
import 'package:hall_sync/features/domain/repositories/slot_repository.dart';

class SlotRepositoryImpl extends SlotRepository{
  final FirebaseRemoteDataStore remoteDataSource;
  SlotRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> bookSlot(SlotEntity slot) => 
    remoteDataSource.bookSlot(slot);

  @override
  Future<void> deleteSlot(SlotEntity slot) => 
    remoteDataSource.deleteSlot(slot);

  @override
  Stream<List<SlotEntity>> getAllSlots() => 
    remoteDataSource.getAllSlots();

  @override
  Stream<List<SlotEntity>> getApprovedSlots() => 
    remoteDataSource.getApprovedSlots();

  @override
  Stream<List<SlotEntity>> getUserSlots(String uid) => 
    remoteDataSource.getUserSlots(uid);

  @override
  Future<void> toggleSlotApproval(SlotEntity slot) => 
    remoteDataSource.toggleSlotApproval(slot);

  @override
  Future<void> updateSlot(SlotEntity slot) => 
    remoteDataSource.updateSlot(slot);

}