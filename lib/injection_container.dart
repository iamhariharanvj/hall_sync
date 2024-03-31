import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:get_it/get_it.dart";
import "package:hall_sync/features/data/data_sources/remote/firebase_remote_data_source.dart";
import "package:hall_sync/features/data/data_sources/remote/firebase_remote_data_source_impl.dart";
import "package:hall_sync/features/data/repositories/slot_repository_impl.dart";
import "package:hall_sync/features/data/repositories/user_repository_impl.dart";
import "package:hall_sync/features/domain/repositories/slot_repository.dart";
import "package:hall_sync/features/domain/repositories/user_repository.dart";
import "package:hall_sync/features/domain/usecases/book_slot_usecase.dart";
import "package:hall_sync/features/domain/usecases/delete_slot_usecase.dart";
import "package:hall_sync/features/domain/usecases/get_all_slots_usecase.dart";
import "package:hall_sync/features/domain/usecases/get_approved_slots_usecase.dart";
import "package:hall_sync/features/domain/usecases/get_create_current_user_usecase.dart";
import "package:hall_sync/features/domain/usecases/get_current_uid_usecase.dart";
import "package:hall_sync/features/domain/usecases/get_role_usecase.dart";
import "package:hall_sync/features/domain/usecases/get_user_slots_usecase.dart";
import "package:hall_sync/features/domain/usecases/is_sign_in_usecase.dart";
import "package:hall_sync/features/domain/usecases/sign_in_usecase.dart";
import "package:hall_sync/features/domain/usecases/sign_out_usecase.dart";
import "package:hall_sync/features/domain/usecases/sign_up_usecase.dart";
import "package:hall_sync/features/domain/usecases/toggle_slot_approval_usecase.dart";
import "package:hall_sync/features/domain/usecases/update_slot_usecase.dart";
import "package:hall_sync/features/presentation/cubit/auth/auth_cubit.dart";
import "package:hall_sync/features/presentation/cubit/slot/slot_cubit.dart";
import "package:hall_sync/features/presentation/cubit/user/user_cubit.dart";

GetIt s1 = GetIt.instance;

Future<void> initializeDependencies() async{
  s1.registerFactory(() => AuthCubit(
    isSignInUsecase: s1.call(), 
    getCurrentUIdUsecase: s1.call(), 
    signOutUsecase: s1.call(),
    getRoleUsecase: s1.call()
    ));

  s1.registerFactory(() => UserCubit(
    signInUsecase: s1.call(), 
    signUpUsecase: s1.call(), 
    getCreateCurrentUserUsecase: s1.call()
    ));

  s1.registerFactory(() => SlotCubit(
    bookSlotUsecase: s1.call(), 
    toggleSlotApprovalUsecase: s1.call(), 
    deleteSlotUsecase: s1.call(), 
    getAllSlotsUsecase: s1.call(), 
    getApprovedSlotsUsecase: s1.call(), 
    getUserSlotsUsecase: s1.call(), 
    updateSlotUsecase: s1.call()
    ));

  s1.registerLazySingleton<BookSlotUsecase>(() => BookSlotUsecase(repository: s1.call()));
  s1.registerLazySingleton<DeleteSlotUsecase>(() => DeleteSlotUsecase(repository: s1.call()));
  s1.registerLazySingleton<GetAllSlotsUsecase>(() => GetAllSlotsUsecase(repository: s1.call()));
  s1.registerLazySingleton<GetApprovedSlotsUsecase>(() => GetApprovedSlotsUsecase(repository: s1.call()));
  s1.registerLazySingleton<GetCreateCurrentUserUsecase>(() => GetCreateCurrentUserUsecase(repository: s1.call())); 
  s1.registerLazySingleton<GetCurrentUIdUsecase>(() => GetCurrentUIdUsecase(repository: s1.call()));
  s1.registerLazySingleton<GetRoleUsecase>(() => GetRoleUsecase(repository: s1.call()));
  s1.registerLazySingleton<GetUserSlotsUsecase>(() => GetUserSlotsUsecase(repository: s1.call()));
  s1.registerLazySingleton<IsSignInUsecase>(() => IsSignInUsecase(repository: s1.call()));
  s1.registerLazySingleton<SignInUsecase>(() => SignInUsecase(repository: s1.call()));
  s1.registerLazySingleton<SignOutUsecase>(() => SignOutUsecase(repository: s1.call()));
  s1.registerLazySingleton<SignUpUsecase>(() => SignUpUsecase(repository: s1.call()));
  s1.registerLazySingleton<ToggleSlotApprovalUsecase>(() => ToggleSlotApprovalUsecase(repository: s1.call()));
  s1.registerLazySingleton<UpdateSlotUsecase>(() => UpdateSlotUsecase(repository: s1.call()));
  
  s1.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(remoteDataSource: s1.call()));
  s1.registerLazySingleton<SlotRepository>(() => SlotRepositoryImpl(remoteDataSource: s1.call()));
  s1.registerLazySingleton<FirebaseRemoteDataStore>(() => FirebaseRemoteDataSourceImpl(auth: s1.call(), firestore: s1.call()));

  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;

  s1.registerLazySingleton(() => auth);
  s1.registerLazySingleton(() => fireStore);

}