import 'dart:io';

import 'package:database_2/models/student.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class StudentView extends StatelessWidget {
  final box = Hive.box<Student>('student');
  final List<Student> obj;
  final int index;
  StudentView({Key? key, required this.obj, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Student Details'),
        centerTitle: true,
        elevation: 10,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
                radius: 50,
                backgroundColor: Colors.green.shade100,
                child: obj[index].imagePath == null
                    ? null
                    : ClipOval(
                        child: Image.file(
                          File(obj[index].imagePath),
                          width: 160,
                          height: 160,
                          fit: BoxFit.cover,
                        ),
                      )),
            const SizedBox(height: 10),
            Text(
              'Name : ${obj[index].name}',
              style: const TextStyle(color: Colors.red, fontSize: 35),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Place : ${obj[index].place}',
              style: const TextStyle(color: Colors.black, fontSize: 25),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              ('Age : ${obj[index].age}'),
              style: const TextStyle(color: Colors.black, fontSize: 25),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              ('Qualification : ${obj[index].qualification}'),
              style: const TextStyle(color: Colors.black, fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
