
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NavigationItem{
  final Widget widget;
  final String label;
  final IconData icon;
  final IconData selectedIcon;
  const NavigationItem({required this.widget, required this.label, required this.icon, required this.selectedIcon});
}

class BottomNavBar extends StatefulWidget {
  final List<NavigationItem> navItems;
  const BottomNavBar({super.key, required this.navItems});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: widget.navItems.map((navItem) => 
        NavigationDestination(
            selectedIcon: Icon(navItem.icon),
            icon: Icon(navItem.icon),
            label: navItem.label,
          )
        ).toList()
      ),
      body: widget.navItems[currentPageIndex].widget,
    );
  }
}
