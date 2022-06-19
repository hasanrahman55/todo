import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';

import 'package:todo/aplication/app_provider.dart';
import 'package:todo/domain/todo.dart';

import '../aplication/app_state.dart';

class AddTodoScreen extends HookConsumerWidget {
  const AddTodoScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleControler = useTextEditingController();
    final detailsControler = useTextEditingController();
    final state = ref.watch(appProvider);
    ref.listen<AppState>(appProvider, (p, n) {
      if (p!.loading && !n.loading) {
        Navigator.pop(context);
      }
    });
    final ValueNotifier<File?> imageL = useState(null);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (state.loading) const LinearProgressIndicator(),
            SizedBox(height: 40),
            TextFormField(
              controller: titleControler,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Title",
              ),
            ),
            SizedBox(height: 30),
            TextFormField(
              textAlign: TextAlign.start,
              maxLines: 5,
              controller: detailsControler,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Details",
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () async {
                imageL.value = await pickImageCamera();
              },
              child: Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image,
                      color: Colors.white,
                    ),
                    SizedBox(width: 20),
                    Text(
                      "Add Image",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (imageL.value != null) {
                  final todo = Todo(
                    title: titleControler.text,
                    details: detailsControler.text,
                    createdAt: DateTime.now(),
                    image: imageL.value!,
                  );

                  ref.read(appProvider.notifier).addTodo(todo);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Please select a image first"),
                  ));
                }
              },
              child: const Text("Add Reoport"),
            ),
          ],
        ),
      ),
    );
  }

  Future<File?> pickImageCamera() async {
    try {
      XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return null;
      return File(image.path);
    } catch (e) {
      return null;
    }
  }
}
