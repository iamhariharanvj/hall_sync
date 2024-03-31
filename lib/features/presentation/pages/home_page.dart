import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hall_sync/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:hall_sync/features/presentation/cubit/slot/slot_cubit.dart';
import 'package:hall_sync/features/presentation/pages/book_events_page.dart';
import 'package:hall_sync/features/presentation/pages/view_events_page.dart';
import 'package:hall_sync/features/presentation/pages/view_my_events_page.dart';
import 'package:hall_sync/features/presentation/widgets/bottom_navigation_bar_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String uid;
  const HomePage({Key? key, required this.uid}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: BottomNavBar(
        navItems: [
          NavigationItem(
            widget: BookEventsPage(uid: widget.uid), 
            icon: Icons.book, 
            selectedIcon: Icons.book_outlined, 
            label: "Book Events"
          ),

          NavigationItem(
            widget: ViewEventsPage(uid: widget.uid,), 
            icon: Icons.event, 
            selectedIcon: Icons.event_outlined, 
            label: "Events"
          ),

          NavigationItem(
            widget: ViewMyEventsPage(uid: widget.uid), 
            icon: Icons.person, 
            selectedIcon: Icons.person_outlined, 
            label: "My Events"
          ),
        ],
      ),
    );
  }
}
