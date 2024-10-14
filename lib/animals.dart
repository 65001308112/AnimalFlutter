import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'one_animal.dart'; // Import the OneAnimal screen

class AnimalList extends StatefulWidget {
  final Function(String) onTitleChange;

  const AnimalList({super.key, required this.onTitleChange});

  @override
  State<AnimalList> createState() => _AnimalListState();
}

class _AnimalListState extends State<AnimalList> {
  List<Map<String, String>> _animals = [];

  @override
  void initState() {
    super.initState();
    _fetchAnimals();
  }

  void _fetchAnimals() async {
    final databaseReference = FirebaseDatabase.instance.ref('animal'); // Use 'animal' as the reference
    DatabaseEvent event = await databaseReference.once();
    final DataSnapshot snapshot = event.snapshot;

    if (snapshot.exists) {
      List<Map<String, String>> animalList = [];
      for (var animal in snapshot.children) {
        animalList.add({
          'name': animal.child('name').value?.toString() ?? 'Unknown',
          'image': animal.child('image').value?.toString() ?? '',
          'description': animal.child('description').value?.toString() ?? 'No description available',
          'id': animal.key ?? '', // Ensure the key is not null
        });
      }
      setState(() {
        _animals = animalList;
      });
    }
  }

  void _addAnimal() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController imageController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Animal'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Animal Name'),
              ),
              TextField(
                controller: imageController,
                decoration: const InputDecoration(labelText: 'Image URL'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                String name = nameController.text.trim();
                String image = imageController.text.trim();
                String description = descriptionController.text.trim();

                if (name.isNotEmpty && image.isNotEmpty) {
                  _saveAnimal(name, image, description);
                  Navigator.of(context).pop(); // Close the dialog
                }
              },
              child: const Text('Add'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _saveAnimal(String name, String image, String description) {
    final databaseReference = FirebaseDatabase.instance.ref('animal'); // Change to 'animal'
    databaseReference.push().set({
      'name': name,
      'image': image,
      'description': description,
    }).then((_) {
      _fetchAnimals(); // Refresh the list after adding
    });
  }

  void _navigateToAnimalDetails(Map<String, String> animal) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OneAnimal(
          name: animal['name']!,
          image: animal['image']!,
          description: animal['description']!,
          onDelete: () => _deleteAnimal(animal['id']!), // Pass delete function
        ),
      ),
    );
  }

  void _deleteAnimal(String animalId) {
    final databaseReference = FirebaseDatabase.instance.ref('animal/$animalId'); // Change to 'animal'
    databaseReference.remove().then((_) {
      _fetchAnimals(); // Refresh the list after deletion
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Animal List'),
      ),
      body: _animals.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _animals.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    leading: _animals[index]['image']!.isNotEmpty
                        ? Image.network(
                            _animals[index]['image']!,
                            width: 50, // Fixed size
                            height: 50, // Fixed size
                            fit: BoxFit.cover,
                          )
                        : const SizedBox(
                            width: 50,
                            height: 50,
                            child: Icon(Icons.broken_image), // Placeholder for no image
                          ),
                    title: Text(
                      _animals[index]['name']!,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      _animals[index]['description']!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis, // To limit the text
                    ),
                    onTap: () => _navigateToAnimalDetails(_animals[index]), // Navigate on tap
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addAnimal,
        tooltip: 'Add Animal',
        child: const Icon(Icons.add),
      ),
    );
  }
}
