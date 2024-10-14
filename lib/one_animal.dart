import 'package:flutter/material.dart';

class OneAnimal extends StatelessWidget {
  final String name;
  final String image;
  final String description;
  final Function onDelete; // Callback for delete action

  const OneAnimal({
    super.key,
    required this.name,
    required this.image,
    required this.description,
    required this.onDelete, // Pass the delete function
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Increased image size
            Image.network(
              image,
              fit: BoxFit.contain, // Use contain to prevent cropping
              width: double.infinity, // Make it full width
              height: 300, // Set the height larger
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                description,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onDelete(); // Call the delete function when pressed
          Navigator.of(context).pop(); // Go back after deletion
        },
        tooltip: 'Delete Animal',
        child: const Icon(Icons.delete),
      ),
    );
  }
}
