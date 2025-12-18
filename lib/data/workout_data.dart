import '../models/workout_model.dart';
import '../models/exercise_model.dart';

final List<Workout> workouts = [
  Workout(
    title: "Full Body",
    image: "assets/images/fullbody.png",
    exercises: [
      Exercise(
        name: "Jumping Jacks",
        image: "assets/images/jumpingjacks.png",
        duration: 30,
        calories: 10,
      ),
      Exercise(
        name: "Push Ups",
        image: "assets/images/pushups.png",
        duration: 20,
        calories: 15,
      ),
    ],
  ),
  Workout(
    title: "Abs Workout",
    image: "assets/images/absworkout.png",
    exercises: [
      Exercise(
        name: "Plank",
        image: "assets/images/plank.png",
        duration: 40,
        calories: 20,
      ),
      Exercise(
        name: "Crunches",
        image: "assets/images/crunches.png",
        duration: 30,
        calories: 15,
      ),
    ],
  ),
];
