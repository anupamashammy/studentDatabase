import 'dart:io';
import 'dart:core';
import 'package:database_2/models/student.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({Key? key}) : super(key: key);

  @override
  _AddStudentState createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  var box = Hive.box<Student>('student');
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController qualificationController = TextEditingController();

  XFile? image;
  String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Student'),
      ),
      body: Form(
        // key: widget.formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              if (imagePath != null)
                ClipRRect(
                  child: Image.file(
                    File(imagePath!),
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () => getImage(source: ImageSource.gallery),
                  child: const Text('Select Image')),
              ElevatedButton(
                  onPressed: () => getImage(source: ImageSource.camera),
                  child: const Text('Take an Image')),
              const SizedBox(
                height: 10,
              ),
              TextField(
                  style: const TextStyle(fontSize: 16),
                  controller: nameController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    labelText: 'Name',
                  )),
              const SizedBox(
                height: 10,
              ),
              TextField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 16),
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    labelText: 'Age',
                  )),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: placeController,
                style: const TextStyle(fontSize: 16),
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  labelText: 'Place',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: qualificationController,
                style: const TextStyle(fontSize: 16),
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  labelText: 'qualification',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    box.add(Student(
                        imagePath: imagePath,
                        name: nameController.text,
                        age: int.parse(ageController.text),
                        place: placeController.text,
                        qualification: qualificationController.text));
                    Navigator.pop(context);
                  },
                  child: const Text('SAVE'))
            ],
          ),
        ),
      ),
    );
  }

  getImage({required ImageSource source}) async {
    image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      setState(() {
        imagePath = (image!.path);
      });
    } else {
      return null;
    }
  }
}
