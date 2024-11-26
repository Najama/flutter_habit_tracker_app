import 'package:flutter/material.dart';
import 'package:flutter_assessment_project/src/core/data/model/habit.dart';
import 'package:flutter_assessment_project/src/core/ui/add_habit_screen.dart';
import 'package:flutter_assessment_project/src/core/ui/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../ui/bottom_nav_bar_screen.dart';
import '../ui/details_screen.dart';
import '../ui/error_screen.dart';
import '../ui/login_screen.dart';
import '../ui/profile_screen.dart';
import '../ui/splash_screen.dart';
import '../utils/route_names.dart';
import 'auth_provider.dart';

final _rootNavigatorkey = GlobalKey<NavigatorState>();
final _homeShellNavigatorkey =
    GlobalKey<NavigatorState>(debugLabel: 'HomeShell');
final _profileShellNavigatorkey =
    GlobalKey<NavigatorState>(debugLabel: 'ProfileShell');

final goRouterProvider = Provider<GoRouter>((ref) {
  final authNotifierProvider = ref.watch(authProvider);
  return GoRouter(
      navigatorKey: _rootNavigatorkey,
      debugLogDiagnostics: true,
      refreshListenable: authNotifierProvider,
      initialLocation: RouteNames.splash.path(),
   

      routes: [
        StatefulShellRoute.indexedStack(
            builder: (context, state, navigationShell) =>
                BottomNavBarScreen(navigationShell),
            branches: [
              StatefulShellBranch(
                  navigatorKey: _homeShellNavigatorkey,
                  routes: [
                    GoRoute(
                        parentNavigatorKey: _homeShellNavigatorkey,
                        path: RouteNames.home.path(),
                        name: RouteNames.home,
                         pageBuilder: (context, state) {
                                return CustomTransitionPage(
                                  child: HomeScreen(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    return SlideTransition(
                                      position: Tween<Offset>(
                                        begin: Offset(1, 0),
                                        end:Offset.zero
                                      ).animate(animation),
                                      child: child,
                                    );
                                  },
                                );
                              },
                        routes: [
                          GoRoute(
                            path: RouteNames.details.path(),
                            name: RouteNames.details,
                            builder: (context, state) {
                              final data = state.extra as Habit;
                              return HabitDetailScreen(habit:data);
                            },
                          ),
                            GoRoute(
                            path: RouteNames.addhabit.path(),
                            name: RouteNames.addhabit,
                            builder: (context, state) {
                              return AddHabitScreen();
                            },
                          ),
                      
                        ]),
                  ]),
              StatefulShellBranch(
                  navigatorKey: _profileShellNavigatorkey,
                  routes: [
                    GoRoute(
                      path: RouteNames.profile.path(),
                      name: RouteNames.profile,
                      builder: (context, state) {
                        return ProfileScreen();
                      },
                    ),
                  ])
            ]),
        GoRoute(
          path: RouteNames.splash.path(),
          name: 'splash',
          builder: (context, state) {
            return  SplashScreen();
          },
        ),
        GoRoute(
          path: RouteNames.login.path(),
          name: RouteNames.login,
          builder: (context, state) {
            return  LoginScreen();
          },
        ),
       
      ],
      errorBuilder: (context, state) {
        return ErrorScreen(error: state.error.toString());
      });
});
