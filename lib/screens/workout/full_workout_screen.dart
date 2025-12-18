import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/workout_model.dart';
import '../../models/exercise_model.dart';

class FullWorkoutScreen extends StatefulWidget {
  final Workout workout;

  const FullWorkoutScreen({super.key, required this.workout});

  @override
  State<FullWorkoutScreen> createState() => _FullWorkoutScreenState();
}

class _FullWorkoutScreenState extends State<FullWorkoutScreen> {
  int currentIndex = 0;
  late Exercise currentExercise;
  late int remainingTime;
  Timer? timer;
  bool isRunning = false;
  int totalCaloriesBurned = 0;

  @override
  void initState() {
    super.initState();
    currentExercise = widget.workout.exercises[currentIndex];
    remainingTime = currentExercise.duration;
  }

  void startTimer() {
     HapticFeedback.mediumImpact(); // vibrates on exercise switch
    if (timer != null) return;
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
      } else {
        _nextExercise();
      }
    });
    if (mounted) {
      setState(() {
        isRunning = true;
      });
    }
  }

  void pauseTimer() {
     HapticFeedback.mediumImpact(); // vibrates on exercise switch
    timer?.cancel();
    timer = null;
    if (mounted) {
      setState(() {
        isRunning = false;
      });
    }
  }

  void resetWorkout() {
    pauseTimer();
    setState(() {
      currentIndex = 0;
      currentExercise = widget.workout.exercises[currentIndex];
      remainingTime = currentExercise.duration;
      totalCaloriesBurned = 0;
    });
  }

  void _nextExercise() {
    totalCaloriesBurned +=
        currentExercise.calories - (remainingTime * currentExercise.calories ~/ currentExercise.duration);
         HapticFeedback.mediumImpact(); // vibrates on exercise switch
    if (currentIndex < widget.workout.exercises.length - 1) {
      setState(() {
        currentIndex++;
        currentExercise = widget.workout.exercises[currentIndex];
        remainingTime = currentExercise.duration;
      });
    } else {
      pauseTimer();
      _showWorkoutCompletedDialog();
    }
  }

void _showWorkoutCompletedDialog() {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF56ab2f), Color(0xFFa8e063)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.emoji_events,
              color: Colors.yellow,
              size: 60,
            ),
            const SizedBox(height: 16),
            const Text(
              "Workout Completed!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Total Calories Burned:\n$totalCaloriesBurned cal",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
              onPressed: () {
                Navigator.pop(context); // close dialog
                Navigator.pop(context); // go back to previous screen
              },
              child: const Text(
                "Done",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}


  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progress = (currentExercise.duration - remainingTime) / currentExercise.duration;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.workout.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Exercise ${currentIndex + 1}/${widget.workout.exercises.length}",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Image.asset(currentExercise.image, height: 200),
            const SizedBox(height: 24),
            Text(
              "${remainingTime}s",
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
           AnimatedContainer(
  duration: const Duration(milliseconds: 500),
  height: 10,
  width: double.infinity,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    gradient: LinearGradient(
      colors: [Colors.green, Colors.yellow],
    ),
  ),
  child: FractionallySizedBox(
    alignment: Alignment.centerLeft,
    widthFactor: progress, // progress 0 to 1
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
),

            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: isRunning ? pauseTimer : startTimer,
                  child: Text(isRunning ? "Pause" : "Start"),
                ),
                ElevatedButton(
                  onPressed: resetWorkout,
                  child: const Text("Reset"),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              "Total Calories Burned: $totalCaloriesBurned cal",
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
