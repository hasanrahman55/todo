import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo/aplication/app_provider.dart';

class DetailPage extends HookConsumerWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(appProvider);

    final ValueNotifier<File?> imageL = useState(null);

    useEffect((() {
      Future.delayed(Duration(milliseconds: 10), () {
        ref.read(appProvider.notifier).loadData();
      });
    }), []);
    return Scaffold(
      body: state.loading
          ? Center(child: const CircularProgressIndicator())
          : state.listOfTodo.isNotEmpty
              ? Column(
                  children: [
                    Container(
                      height: 60,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Text(
                          //   todo.title[index],
                          //   style: TextStyle(color: Colors.black, fontSize: 30),
                          // ),
                          // SizedBox(height: 30),
                          // Text(
                          //   todo.details[index],
                          //   style: TextStyle(color: Colors.black),
                          // ),
                          // SizedBox(height: 30),
                          // Image.file(
                          //   todo.image[index],
                          //   // fit: BoxFit.,
                          // ),
                        ],
                      ),
                    ),
                  ],
                )
              : Center(child: Text("Add Data")),
    );
  }
}
