import 'package:flutter/material.dart';

class MentalExercisesScreen extends StatelessWidget {
  final List<String> exercises = [
    "Breathing Exercise",
    "Meditation",
    "Mindfulness",
    "Stretching",
    "Positive Affirmations"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mental Exercises'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: exercises.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: const Icon(Icons.fitness_center, color: Colors.blueAccent),
                title: Text(exercises[index]),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Starting ${exercises[index]}...'),
                  ));
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
