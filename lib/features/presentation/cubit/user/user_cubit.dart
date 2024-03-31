
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hall_sync/features/domain/entities/user_entity.dart';
import 'package:hall_sync/features/domain/usecases/get_create_current_user_usecase.dart';
import 'package:hall_sync/features/domain/usecases/sign_in_usecase.dart';
import 'package:hall_sync/features/domain/usecases/sign_up_usecase.dart';

part "user_state.dart";

class UserCubit extends Cubit<UserState>{
  final SignInUsecase signInUsecase;
  final SignUpUsecase signUpUsecase;
  final GetCreateCurrentUserUsecase getCreateCurrentUserUsecase;

  UserCubit({required this.signInUsecase, required this.signUpUsecase, required this.getCreateCurrentUserUsecase}):super(UserInitial());

  Future<void> handleSignIn({required UserEntity user}) async {
    emit(UserLoading());
    try{
      await signInUsecase.call(user);
      emit(UserSuccess(user: user));
    }
    on SocketException catch(_){
      emit(UserFailure());
    }
    catch(_){
      emit(UserFailure());
    }
  }

  Future<void> handleSignup({required UserEntity user}) async {
    emit(UserLoading());
    try{
      await signUpUsecase(user);
      await getCreateCurrentUserUsecase(user);
      emit(UserSuccess(user: user));
    }
    on SocketException catch(_){
      emit(UserFailure());
    }
    catch(_){
      UserFailure();
    }
  }
}