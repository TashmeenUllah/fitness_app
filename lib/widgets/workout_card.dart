import 'package:flutter/material.dart';
import '../models/workout_model.dart';

class WorkoutCard extends StatelessWidget {
  final Workout workout;
  final VoidCallback onTap;

  const WorkoutCard({
    super.key,
    required this.workout,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
       decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(16),
  image: DecorationImage(
    
    image: AssetImage(workout.image),
    fit: BoxFit.cover,         // scales image to cover the container
    alignment: Alignment.center, // ensures proper alignment
    colorFilter: ColorFilter.mode(
      Colors.black.withOpacity(0.4),
      BlendMode.darken,
    ),
    
  ),
),

        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                workout.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${workout.exercises.length} Exercises",
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
