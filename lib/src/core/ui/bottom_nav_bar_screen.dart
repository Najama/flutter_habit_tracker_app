import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/bottom_nav_bar_provider.dart';
import 'home_screen.dart';
import 'profile_screen.dart';

class BottomNavBarScreen extends ConsumerWidget {
  BottomNavBarScreen(this.navigationShell, {super.key});
  final  StatefulNavigationShell navigationShell;
  final List<NavigationDestination> navbarItemList = [
    NavigationDestination(icon: Icon(Icons.home),label:'home'),
    NavigationDestination(icon: Icon(Icons.person),label:'profile'),
  ];
  final List<Widget> _screen = [HomeScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomnavBarIndex= ref.watch(bottomNavBarProvider);
    return Scaffold(
     
      bottomNavigationBar: NavigationBar(
        destinations: navbarItemList,
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (int index)
        {
          navigationShell.goBranch(index,
          initialLocation: index==navigationShell.currentIndex);
           // ref.read(bottomNavBarProvider.notifier).setIndex(index);
        },
        ),
      body:navigationShell
    );
  }
}
