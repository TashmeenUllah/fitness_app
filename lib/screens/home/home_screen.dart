import 'package:flutter/material.dart';
import '../../data/workout_data.dart';
import '../../widgets/workout_card.dart';
import '../workout/exercise_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fitness App"),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: workouts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),
        itemBuilder: (context, index) {
          final workout = workouts[index];
          return WorkoutCard(
            workout: workout,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      ExerciseListScreen(workout: workout),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
