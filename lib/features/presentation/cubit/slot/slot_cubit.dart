import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hall_sync/features/domain/entities/slot_entity.dart';
import 'package:hall_sync/features/domain/usecases/book_slot_usecase.dart';
import 'package:hall_sync/features/domain/usecases/delete_slot_usecase.dart';
import 'package:hall_sync/features/domain/usecases/get_all_slots_usecase.dart';
import 'package:hall_sync/features/domain/usecases/get_approved_slots_usecase.dart';
import 'package:hall_sync/features/domain/usecases/get_user_slots_usecase.dart';
import 'package:hall_sync/features/domain/usecases/toggle_slot_approval_usecase.dart';
import 'package:hall_sync/features/domain/usecases/update_slot_usecase.dart';

part 'slot_state.dart';

class SlotCubit extends Cubit<SlotState>{

  final BookSlotUsecase bookSlotUsecase;
  final ToggleSlotApprovalUsecase toggleSlotApprovalUsecase;
  final UpdateSlotUsecase updateSlotUsecase;
  final DeleteSlotUsecase deleteSlotUsecase;
  final GetAllSlotsUsecase getAllSlotsUsecase;
  final GetUserSlotsUsecase getUserSlotsUsecase;
  final GetApprovedSlotsUsecase getApprovedSlotsUsecase;

  SlotCubit({required this.bookSlotUsecase, required this.toggleSlotApprovalUsecase, required this.deleteSlotUsecase, required this.getAllSlotsUsecase, required this.getApprovedSlotsUsecase, required this.getUserSlotsUsecase, required this.updateSlotUsecase}): super(SlotInitial());

  Future<void> bookSlot({required SlotEntity slot})async {
    try{
      await bookSlotUsecase(slot);
    }
    on SocketException catch(_){
      emit(SlotFailure());
    }
    catch(_){
      emit(SlotFailure());
    }
  }

  Future<void> updateSlot({required SlotEntity slot})async {
    try{
      await updateSlotUsecase(slot);
    }
    on SocketException catch(_){
      emit(SlotFailure());
    }
    catch(_){
      emit(SlotFailure());
    }
  }

  Future<void> deleteSlot({required SlotEntity slot})async {
    try{
      await deleteSlotUsecase(slot);
    }
    on SocketException catch(_){
      emit(SlotFailure());
    }
    catch(_){
      emit(SlotFailure());
    }
  }

  Future<void> toggleApproval({required SlotEntity slot})async {
    try{
      await toggleSlotApprovalUsecase(slot);
    }
    on SocketException catch(_){
      emit(SlotFailure());
    }
    catch(_){
      emit(SlotFailure());
    }
  }

  Future<void> getAllSlots()async {
    emit(SlotLoading());
    try{
      getAllSlotsUsecase().listen((slots) {
        emit(SlotLoaded(slots: slots));
      });
    }
    on SocketException catch(_){
      emit(SlotFailure());
    }
    catch(_){
      emit(SlotFailure());
    }
  }

  Future<void> getApprovedSlots()async {
    emit(SlotLoading());
    try{
      getApprovedSlotsUsecase().listen((slots) {
        emit(SlotLoaded(slots: slots));
      });
    }
    on SocketException catch(_){
      emit(SlotFailure());
    }
    catch(_){
      emit(SlotFailure());
    }
  }

  Future<void> getUserSlots({required String uid})async {
    emit(SlotLoading());
    try{
      getUserSlotsUsecase(uid).listen((slots) {
        emit(SlotLoaded(slots: slots));
      });
    }
    on SocketException catch(_){
      emit(SlotFailure());
    }
    catch(_){
      emit(SlotFailure());
    }
  }

}