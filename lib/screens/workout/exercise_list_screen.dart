import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/screens/workout/exercise_detail_screen.dart';
import '../../models/workout_model.dart';

class ExerciseListScreen extends StatelessWidget {
  final Workout workout;

  const ExerciseListScreen({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(workout.title),
      ),
      body: ListView.builder(
        itemCount: workout.exercises.length,
        itemBuilder: (context, index) {
          final exercise = workout.exercises[index];
          return ListTile(
            leading: Image.asset(
              exercise.image,
              width: 50,
            ),
           title: Text(exercise.name),
            subtitle: Text("${exercise.duration} sec • ${exercise.calories} cal"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ExerciseDetailScreen(exercise: exercise),
                ),
              );
        },
          );
        },
      )
    );
    
  }
}
