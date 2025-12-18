import 'dart:async';
import 'package:flutter/material.dart';
import '../../models/exercise_model.dart';
import 'package:flutter/services.dart';

class ExerciseDetailScreen extends StatefulWidget {
  final Exercise exercise;

  const ExerciseDetailScreen({super.key, required this.exercise});

  @override
  State<ExerciseDetailScreen> createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends State<ExerciseDetailScreen> {
  late int remainingTime;
  Timer? timer;
  bool isRunning = false;

  @override
  void initState() {
    super.initState();
    remainingTime = widget.exercise.duration;
  }

 void startTimer() {
  HapticFeedback.mediumImpact();
  if (timer != null) return; // Prevent multiple timers
  timer = Timer.periodic(const Duration(seconds: 1), (t) {
    if (!mounted) return; // prevent update after dispose
    if (remainingTime > 0) {
      setState(() {
        remainingTime--;
      });
    } else {
      stopTimer();
    }
  });
  if (mounted) {
    setState(() {
      isRunning = true;
    });
  }
}

  void stopTimer() {
    HapticFeedback.mediumImpact();
  timer?.cancel();
  timer = null;
  if (mounted) {
    setState(() {
      isRunning = false;
    });
  }
}


  void resetTimer() {
    stopTimer();
    setState(() {
      remainingTime = widget.exercise.duration;
    });
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exercise.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(widget.exercise.image, height: 200),
            const SizedBox(height: 24),
            Text(
              "$remainingTime sec",
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: (widget.exercise.duration - remainingTime) / widget.exercise.duration,
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  
                  onPressed: isRunning ? stopTimer : startTimer,
                  child: Text(isRunning ? "Pause" : "Start"),
                ),
                ElevatedButton(
                  onPressed: resetTimer,
                  child: const Text("Reset"),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              "Calories: ${widget.exercise.calories - (remainingTime * widget.exercise.calories ~/ widget.exercise.duration)} cal",
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
