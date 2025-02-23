import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/constants/utils.dart';
import 'package:frontend/features/auth/pages/add_new_task_page.dart';
import 'package:frontend/features/home/widgets/date_selector.dart';
import 'package:frontend/features/home/widgets/task_card.dart';

class HomePage extends StatelessWidget {
  static MaterialPageRoute route() => MaterialPageRoute(
        builder: (context) => const HomePage(),
      );
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Tasks'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, AddNewTaskPage.route());
            },
            icon: const Icon(CupertinoIcons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          const DateSelector(),
          Row(
            children: [
              Expanded(
                child: TaskCard(
                  color: Color.fromRGBO(246, 222, 194, 1),
                  headerText: 'Task 1',
                  descriptionText:
                      'This is a task This is a task This is a task This is a task This is a task This is a task',
                ),
              ),
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: strengthColor(Color.fromRGBO(246, 222, 194, 1), 0.5),
                  shape: BoxShape.circle,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  '10:00AM',
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
