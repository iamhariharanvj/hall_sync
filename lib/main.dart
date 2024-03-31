import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hall_sync/config/firebase_options.dart';
import 'package:hall_sync/config/routes/routes.dart';
import 'package:hall_sync/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:hall_sync/features/presentation/cubit/slot/slot_cubit.dart';
import 'package:hall_sync/features/presentation/cubit/user/user_cubit.dart';
import 'package:hall_sync/features/presentation/pages/admin_home_page.dart';
import 'package:hall_sync/features/presentation/pages/home_page.dart';
import 'package:hall_sync/features/presentation/pages/sign_in_page.dart';
import 'injection_container.dart' as di;
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await di.initializeDependencies();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (_)=> di.s1<AuthCubit>()..appStarted()),
        BlocProvider<UserCubit>(create: (_)=> di.s1<UserCubit>()),
        BlocProvider<SlotCubit>(create: (_)=> di.s1<SlotCubit>())
      ], 
    child: MaterialApp(
      title: "Hall Sync",
      onGenerateRoute: onGenerateRoute.route,
      initialRoute: '/',
      routes: {
        '/': (context) {
          return BlocBuilder<AuthCubit, AuthState>(builder: (context, authState){
            
            if(authState is Authenticated){
              if(authState.role=='viewer') return HomePage(uid: authState.uid);
              if(authState.role=='admin') return AdminHomePage(uid: authState.uid);
              return const ErrorPage();
            }
            if(authState is UnAuthenticated){
              return const SignInPage();
            }
            return const CircularProgressIndicator();
          });
        }
      },
    ));
  }
}