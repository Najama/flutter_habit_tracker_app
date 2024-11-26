import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'src/core/data/model/habit.dart';
import 'src/core/providers/go_router_provider.dart';
import 'src/core/providers/theme_provider.dart';
import 'src/core/theme/styles.dart';



Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(HabitAdapter());
  runApp(const ProviderScope(child: AssesmentApp()));
}

class AssesmentApp extends ConsumerStatefulWidget {
const AssesmentApp({ super.key });

  @override
  ConsumerState<AssesmentApp> createState() => _AssesmentAppState();
}

class _AssesmentAppState extends ConsumerState<AssesmentApp> {
  @override void initState() {
    super.initState();
    Future.microtask(() async{
        await ref.read(themeModeProvider.notifier).getTheme();
    });
  }
  @override
  Widget build(BuildContext context){
  final themeMode = ref.watch(themeModeProvider);
  final goRouterConfig= ref.watch(goRouterProvider);

    return MaterialApp.router(
      routerConfig: goRouterConfig,
      theme: !themeMode ? Styles.themeData(isDarkTheme: false): Styles.themeData(isDarkTheme: true),
    
    );
  }
}

