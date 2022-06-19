import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo/aplication/app_provider.dart';
import 'package:todo/presentation/add_todo_screen.dart';
import 'package:todo/presentation/details_page.dart';

class Home extends HookConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(appProvider);
    useEffect((() {
      Future.delayed(Duration(milliseconds: 10), () {
        ref.read(appProvider.notifier).loadData();
      });
    }), []);
    return Scaffold(
      body: state.loading
          ? Center(child: const CircularProgressIndicator())
          : state.listOfTodo.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.listOfTodo.length,
                  itemBuilder: ((context, index) {
                    final todo = state.listOfTodo[index];
                    return InkWell(
                      onTap: (() {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DetailPage(),
                          ),
                        );
                      }),
                      child: Container(
                        color: Colors.blue,
                        margin: EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 10),
                        height: 60,
                        child: Row(
                          children: [
                            Image.file(
                              todo.image,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(width: 40),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  todo.title,
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  todo.details,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                )
              : Center(child: Text("Add Data")),
      floatingActionButton: FloatingActionButton(onPressed: (() {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AddTodoScreen()));
      })),
    );
  }
}
//  return ListTile(
//                       dense: true,
//                       contentPadding: EdgeInsets.zero,
//                       tileColor: Colors.deepPurple,
//                       title: Text(todo.title),
//                       subtitle: Text(todo.details),
//                       leading: Image.file(
//                         todo.image,
//                         fit: BoxFit.cover,
//                       ),
//                     );
