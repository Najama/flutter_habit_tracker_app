import 'package:flutter/material.dart';
import 'package:flutter_assessment_project/src/core/providers/api_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/habit_provider.dart';
import '../providers/theme_provider.dart';
import '../utils/route_names.dart';
import 'habit_card.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
        
    final habits = ref.watch(habitProvider);
    final themeMode = ref.watch(themeModeProvider);

    final completedHabits = habits
        .where((habit) => habit.completionrate >= habit.targetfrequency)
        .length;
    int streak = 0;
    for (final habit in habits) {
      streak += habit.streak;
    }
    final quoteList = ref.watch(quoteProvider);
    final habitCategories = ['Running' ,'reading','Movies', 'Singing', 'Gym'];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            floating: false,
            pinned: true,
            actions: [
              IconButton(
                onPressed: () {
                  ref.read(themeModeProvider.notifier).setTheme();
                },
                icon: Icon(themeMode ? Icons.lightbulb : Icons.dark_mode),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              titlePadding:
                  EdgeInsets.all(24), // Align title
              title: Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Daily Progress',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    Text('Total Habits Completed: $completedHabits',
                        style: TextStyle(fontSize: 14, color: Colors.white)),
                    Text('Total Streak: $streak days',
                        style: TextStyle(fontSize: 14, color: Colors.white)),

                     Padding(
                       padding: const EdgeInsets.only(top:8.0),
                       child: quoteList.when(
                                           data: (quote) {
                        return Text('Quote: ${quote.first.quote}',
                            style:
                                TextStyle(fontSize: 16, color: Colors.white));
                                           },
                                           loading: () => Center(
                          child: CircularProgressIndicator(color: Colors.white)),
                                           error: (error, stack) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text('Error fetching quote',
                            style: TextStyle(color: Colors.white)),
                                           ),
                                         ),
                     ),
              
                  ],
                ),
              ),
              background: Container(
                color: Colors.blue,
               ),
            ),
          ),

          
       SliverList(
  delegate: SliverChildBuilderDelegate(
    (context, index) {
      final habit = habits[index];
      return HabitCard(habit: habit);
    },
    childCount: habits.length,
  ),
),

SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final category = habitCategories[index];
                return Card(
                      child: Center(
                        child: Text(
                                  category,
                                  style: Theme.of(context).textTheme.bodyLarge)
                      ),
                 );
              },
              childCount: habitCategories.length,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(RouteNames.addhabit);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
