import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_app/Model/updateTaskData.dart';

import '../Model/Task.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key, required this.updateTask});

  final void Function(Task, int) updateTask;
  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  @override
  late updateTaskData data;
  DateFormat formatter = DateFormat.yMd();
  DateTime? _selectedDate;
  Category? currentCategory;
  RateCount? currentRate;
  String? _selectedTitle;
  int _selectedCount = 0;
  var cat;
  TextEditingController _countController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  void _showDatePicker() async {
    DateTime now = DateTime.now();
    DateTime first = DateTime(now.year - 5, now.month, now.day);

    var date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: first,
      lastDate: now,
      cancelText: "Close The Picker",
      confirmText: "Select",
    );
    setState(() {
      _selectedDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments as updateTaskData;

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(bottom: 15.0, left: 20),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.white,
          ),
        ),
        toolbarHeight: 130,
        flexibleSpace: ClipPath(
          clipper: MyCustomClip(),
          child: Container(
            padding: const EdgeInsets.only(top: 8),
            alignment: Alignment.center,
            height: 200,
            color: const Color.fromARGB(255, 92, 56, 154),
            child: const Text(
              "Update Your Task ",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              initialValue: data.task.title,
              onChanged: (value) {
                setState(() {
                  _selectedTitle = value;
                });
              },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.deepPurple.shade200,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0)),
                  labelText: "Title",
                  labelStyle: const TextStyle(fontSize: 14)),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              initialValue: "${data.task.count}",
              onChanged: (value) {
                setState(() {
                  _selectedCount = int.parse(value);
                });
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Count",
                suffixText: "times",
                labelStyle: const TextStyle(fontSize: 14),
                filled: true,
                fillColor: Colors.deepPurple.shade200,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(_selectedDate == null
                      ? "${data.task.formattedDate}"
                      : formatter.format(_selectedDate!)),
                  IconButton(
                    onPressed: _showDatePicker,
                    icon: const Icon(
                      Icons.calendar_month_rounded,
                      color: Color.fromARGB(255, 115, 69, 231),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton(
                  alignment: Alignment.center,
                  value: currentCategory == null
                      ? data.task.category
                      : currentCategory,
                  items: Category.values
                      .map((category) => DropdownMenuItem(
                            alignment: Alignment.center,
                            child: Text(
                              "${category.name}",
                              style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 114, 87, 186),
                                  fontWeight: FontWeight.w400),
                            ),
                            value: category,
                          ))
                      .toList(),
                  onChanged: (category) {
                    setState(() {
                      currentCategory = category!;
                    });
                  },
                ),
                const SizedBox(
                  width: 40,
                ),
                DropdownButton(
                  alignment: Alignment.center,
                  value:
                      currentRate == null ? data.task.rateCount : currentRate,
                  items: RateCount.values
                      .map((rate) => DropdownMenuItem(
                            alignment: Alignment.center,
                            child: Text(
                              "${rate.name}",
                              style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 114, 87, 186),
                                  fontWeight: FontWeight.w400),
                            ),
                            value: rate,
                          ))
                      .toList(),
                  onChanged: (rate) {
                    setState(() {
                      currentRate = rate!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widget.updateTask(
                          Task(
                              category: currentCategory == null
                                  ? data.task.category
                                  : currentCategory!,
                              count: _selectedCount,
                              dateTime: _selectedDate == null
                                  ? data.task.dateTime
                                  : _selectedDate!,
                              title: _selectedTitle == null
                                  ? data.task.title
                                  : _selectedTitle!,
                              rateCount: currentRate == null
                                  ? data.task.rateCount
                                  : currentRate!),
                          data.index);
                    });
                    Navigator.pop(context);
                  },
                  child: const Text("Update The Task"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyCustomClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;
    var path = Path();
    path.lineTo(0, height - 50);
    path.quadraticBezierTo(width / 2, height, width, height - 50);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
