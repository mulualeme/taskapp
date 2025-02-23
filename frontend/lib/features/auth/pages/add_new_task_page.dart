import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddNewTaskPage extends StatefulWidget {
  static MaterialPageRoute route() {
    return MaterialPageRoute(
      builder: (context) => AddNewTaskPage(),
    );
  }

  @override
  _AddNewTaskPageState createState() => _AddNewTaskPageState();
}

class _AddNewTaskPageState extends State<AddNewTaskPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  Color selectedColor = Color.fromRGBO(246, 222, 146, 1);
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add New Task'),
        actions: [
          GestureDetector(
            onTap: () async {
              final _selectedDate = await showDatePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 90)),
              );
              if (_selectedDate != null) {
                setState(() {
                  selectedDate = _selectedDate;
                });
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                DateFormat('dd/MM/yyyy').format(selectedDate),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Title',
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                hintText: 'Description',
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 10),
            ColorPicker(
              heading: const Text('Select Color'),
              subheading: const Text('Select a different shade '),
              onColorChanged: (Color color) {
                setState(() {
                  selectedColor = color;
                });
              },
              color: selectedColor,
              pickersEnabled: const {
                ColorPickerType.wheel: true,
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              child: const Text(
                'SUBMIT',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
