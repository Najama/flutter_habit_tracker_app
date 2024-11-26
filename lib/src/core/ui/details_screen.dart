import 'package:flutter/material.dart';

import '../data/model/habit.dart';

class HabitDetailScreen extends StatelessWidget {
  final Habit habit;

  HabitDetailScreen({required this.habit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(habit.name ?? ""),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              habit.name ?? "",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 8),
            Text('Category: ${habit.completionrate}'),
            SizedBox(height: 8),
            Text('Streak: ${habit.streak} days'),
           
          ],
        ),
      ),
    );
  }
}
