import 'package:hall_sync/features/domain/entities/slot_entity.dart';
import 'package:hall_sync/features/domain/entities/user_entity.dart';

abstract class FirebaseRemoteDataStore{
  Future<bool> isSignIn();
  Future<void> signIn(UserEntity user);
  Future<void> signUp(UserEntity user);
  Future<void> signOut();
  Future<String> getCurrentUId();
  Future<String> getRole(String uid);
  Future<void> getCreateCurrentUser(UserEntity user);
  Future<void> bookSlot(SlotEntity slot);
  Future<void> updateSlot(SlotEntity slot);
  Future<void> deleteSlot(SlotEntity slot);
  Future<void> toggleSlotApproval(SlotEntity slot);
  Stream<List<SlotEntity>> getUserSlots(String uid);
  Stream<List<SlotEntity>> getAllSlots();
  Stream<List<SlotEntity>> getApprovedSlots();
}