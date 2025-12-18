import 'exercise_model.dart';

class Workout {
  final String title;
  final String image;
  final List<Exercise> exercises;

  Workout({
    required this.title,
    required this.image,
    required this.exercises,
  });
}
