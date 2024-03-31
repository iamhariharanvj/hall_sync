import 'package:flutter/material.dart';
import 'package:hall_sync/config/utils/constants.dart';
import 'package:hall_sync/features/domain/entities/slot_entity.dart';
import 'package:hall_sync/features/presentation/pages/admin_home_page.dart';
import 'package:hall_sync/features/presentation/pages/home_page.dart';
import 'package:hall_sync/features/presentation/pages/sign_in_page.dart';
import 'package:hall_sync/features/presentation/pages/sign_up_page.dart';
import 'package:hall_sync/features/presentation/pages/update_slot_page.dart';

class onGenerateRoute{
  static Route<dynamic> route(RouteSettings settings){
    final arg = settings.arguments;

    switch(settings.name){
      case PageConstants.signupPage:
        return materialBuilder(widget: const SignUpPage());  
      
      case PageConstants.signinPage:
        return materialBuilder(widget: const SignInPage());

      case PageConstants.homePage:
        if(arg is String){
          return materialBuilder(widget: HomePage(uid:arg,));
        }
        else{
          return materialBuilder(widget: const ErrorPage());
        }
      case PageConstants.updateSlotPage:
        if(arg is SlotEntity){
          return materialBuilder(widget: UpdateSlotPage(slot:arg,));
        }
        else{
          return materialBuilder(widget: const ErrorPage());
        }
      case PageConstants.adminHomePage:
        if(arg is String){
          return materialBuilder(widget: AdminHomePage(uid:arg,));
        }
        else{
          return materialBuilder(widget: const ErrorPage());
        }
      default:
        return materialBuilder(widget: const ErrorPage());
    }
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Error")
        ),
      body: const Center(
        child: Text("Error"),
        ),
    );
  }
}

MaterialPageRoute materialBuilder({required Widget widget}){
  return MaterialPageRoute(builder: (_)=>widget);
}

