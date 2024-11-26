import 'package:flutter/material.dart';
import 'package:flutter_assessment_project/src/core/data/model/habit.dart';
import 'package:flutter_assessment_project/src/core/ui/bottom_nav_bar_screen.dart';
import 'package:flutter_assessment_project/src/core/utils/route_names.dart';
import 'package:go_router/go_router.dart';

class HabitCard extends StatelessWidget {
  final Habit habit;
 const HabitCard({
    Key? key,
   required  this.habit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){context.pushNamed(RouteNames.details,extra: habit);},
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    habit.name ?? "",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    habit.completionrate.toString(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            Text(habit.targetfrequency.toString()),
          ],
        ),
      ),
    );
  }
}
