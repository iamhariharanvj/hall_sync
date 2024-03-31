import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hall_sync/features/domain/usecases/get_current_uid_usecase.dart';
import 'package:hall_sync/features/domain/usecases/get_role_usecase.dart';
import 'package:hall_sync/features/domain/usecases/is_sign_in_usecase.dart';
import 'package:hall_sync/features/domain/usecases/sign_out_usecase.dart';

part "auth_state.dart";

class AuthCubit extends Cubit<AuthState>{
  final IsSignInUsecase isSignInUsecase;
  final GetCurrentUIdUsecase getCurrentUIdUsecase;
  final GetRoleUsecase getRoleUsecase;
  final SignOutUsecase signOutUsecase;
  AuthCubit({required this.isSignInUsecase, required this.getCurrentUIdUsecase, required this.signOutUsecase, required this.getRoleUsecase}):super(AuthInitial());

  Future<void> appStarted() async{
    try{
      final isSignIn = await isSignInUsecase.call();
      if(isSignIn){
        final uid = await getCurrentUIdUsecase.call();
        final role = await getRoleUsecase.call(uid);
        emit(Authenticated(uid: uid, role: role));
      }
      else{
        emit(UnAuthenticated());
      }
    }
    on SocketException catch(_){
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedIn() async{
    try{
      final uid = await getCurrentUIdUsecase.call();
      final role = await getRoleUsecase.call(uid);
      emit(Authenticated(uid: uid,role: role));
    }
    on SocketException catch(_){
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedOut() async{
    try{
      await signOutUsecase.call();
      emit(UnAuthenticated());
    }
    on SocketException catch(_){
      emit(UnAuthenticated());
    }
  }
}