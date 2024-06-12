import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projtest/models/app_user.dart';
import 'package:projtest/utils/app_toast.dart';

class SubmitTask extends StatefulWidget {
  const SubmitTask({super.key});

  static const screenRoute = 'Task';

  @override
  State<SubmitTask> createState() => _SubmitTaskState();
}

class _SubmitTaskState extends State<SubmitTask> {
  final taskNameController = TextEditingController();
  final fireAuth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;
  AppUser appUser = AppUser(
    userId: '',
    userName: '',
    email: '',
    studentClub: '',
    profileImage: '',
    role: '',
  );
  String taskId = '';
  String department = '';
  File imageFile = File('');
  File file = File('');

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(.2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: OutlinedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Back',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Text(
            'Submit Task',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
          ),
          const SizedBox(height: 20),
          Expanded(
            flex: 1,
            child: Image.asset('assets/images/CLUB (3).png'),
          ),
          const SizedBox(height: 20),
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              color: Colors.grey[300],
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: taskNameController,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                hintText: 'Task Name',
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    if (taskNameController.text.isNotEmpty &&
                                        department.isNotEmpty) {
                                      addTask();
                                    }
                                  },
                                  icon: const Icon(Icons.send),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerRight,
                              child: DropdownButton<String>(
                                value: department,
                                items: <String>[
                                  'Human Resources',
                                  'Training',
                                  'Development',
                                  'Marketing',
                                  'Public Relationship',
                                  'FR',
                                  'Projects',
                                  'Media',
                                  'Coordination',
                                  'Logistics',
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    department = value!;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                            Visibility(
                              visible: imageFile.path != '',
                              child: ClipRRect(
                                clipBehavior: Clip.hardEdge,
                                borderRadius: BorderRadius.circular(16),
                                child: Image.file(
                                  imageFile,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Visibility(
                              visible: file.path != '',
                              child: const Text(
                                'File Attached',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    pickImage();
                                  },
                                  icon: const Icon(Icons.image),
                                ),
                                IconButton(
                                  onPressed: () {
                                    pickFile();
                                  },
                                  icon: const Icon(Icons.file_copy),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> getUserData() async {
    String userId = fireAuth.currentUser!.uid;
    await fireStore.collection("users").doc(userId).get().then(
      (value) {
        setState(() {
          appUser = AppUser.fromMap(value.data()!);
          department = appUser.role;
        });
      },
    );
  }

  Future<void> addTask() async {
    taskId = DateTime.now().millisecondsSinceEpoch.toString();
    await fireStore.collection('tasks').doc(taskId).set({
      'taskId': taskId,
      'taskName': taskNameController.text,
      'department': department,
      'userName': appUser.userName,
      'userId': appUser.userId,
      'role': appUser.role,
      'studentClub': appUser.studentClub,
      'taskImage': '',
      'taskFile': ''
    });
    if (imageFile.path.isNotEmpty) {
      await uploadImage(imageFile);
    }
    if(file.path.isNotEmpty){
      await uploadFile(file);
    }
    onAddTaskSuccess();
  }

  void onAddTaskSuccess() {
    setState(() {
      taskNameController.text = '';
      imageFile = File('');
      file = File('');
    });
    displayToast('Posted');
  }

  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = File(file!.path);
    });
  }

  Future<void> uploadImage(File image) async {
    String userId = fireAuth.currentUser!.uid;
    await storage.ref('tasksImages/$userId/$taskId').putFile(image).then(
      (value) async {
        await getImageUrl();
      },
    ).catchError(
      (error) {},
    );
  }

  Future<void> getImageUrl() async {
    String userId = fireAuth.currentUser!.uid;
    await storage.ref('tasksImages/$userId/$taskId').getDownloadURL().then(
      (value) {
        fireStore.collection("tasks").doc(taskId).update({
          'taskImage': value,
        });
      },
    ).catchError(
      (error) {},
    );
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        file = File(result.files.single.path!);
      });
    } else {}
  }

  Future<void> uploadFile(File image) async {
    String userId = fireAuth.currentUser!.uid;
    await storage.ref('tasksFiles/$userId/$taskId').putFile(image).then(
      (value) async {
        await getFileUrl();
      },
    ).catchError(
      (error) {},
    );
  }

  Future<void> getFileUrl() async {
    String userId = fireAuth.currentUser!.uid;
    await storage.ref('tasksFiles/$userId/$taskId').getDownloadURL().then(
      (value) {
        fireStore.collection("tasks").doc(taskId).update({
          'taskFile': value,
        });
      },
    ).catchError(
      (error) {},
    );
  }
}
