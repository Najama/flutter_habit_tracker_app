import 'package:flutter/material.dart';
import 'package:flutter_assessment_project/src/core/utils/route_names.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/auth_provider.dart';

class SplashScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(authProvider).isloggedIn;

    Future.delayed(Duration(seconds: 3), () {
      if (isLoggedIn) {
        context.go(RouteNames.home.path());  
      } else {
        context.go(RouteNames.login.path()); 
      }
    });

    return const Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.track_changes,
              size: 100,
              color: Colors.white,
            ),
            SizedBox(height: 20),
            Text(
              'Habit Tracker',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
