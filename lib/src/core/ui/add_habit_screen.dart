
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/model/habit.dart';
import '../providers/habit_provider.dart';



class AddHabitScreen extends ConsumerWidget {
   AddHabitScreen({super.key});

  final TextEditingController controller=TextEditingController();

  final GlobalKey<FormState>_formKey=GlobalKey();

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        
      ),
      body: Form(
        key:_formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                validator: (value){
                  if(value==null && value!.isEmpty ){
                      return 'error';
                  }
                  else
                  return null;
                },
                controller:controller ,
                decoration: const InputDecoration(
                 hintText: 'Add Habit',
                 border:OutlineInputBorder() ,
                 errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red)
                 )
                ),
              ),
              ElevatedButton(onPressed: () async{
                if(_formKey.currentState!.validate()){
                    final habit = Habit(
                    name:"Reading books",
                    completionrate:100,
                    targetfrequency: 2,
                    habitcategory:"Reading"
        );
                ref.read(habitProvider.notifier).addHabit(habit);

                }
              }, child: const Text('Add'))
            ],
          ),
        ),

      ),
    );
  }
}