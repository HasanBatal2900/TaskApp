import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:task_app/Model/Task.dart';
import 'package:intl/intl.dart';

class NewTask extends StatefulWidget {
  const NewTask({super.key});

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  void _showDatePicker() async {
    var now = DateTime.now();
    var first = DateTime(now.year - 1, now.month, now.day);
    var date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: first,
      lastDate: now,
    );

    setState(() {
      _selectedDate = date;
    });
  }

  void _sumbitData() {
    bool invalidCount = count <= 0 || count.isNull;
    if (invalidCount || _selectedDate == null || title==null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            alignment: Alignment.center,
            title: const Text(
              "Invaild Input",
            ),
            content: const Text("Try To Add A Valid Contet Please"),
            actions: [TextButton(onPressed: () {}, child: Text("Okey"))],
          );
        },
      );
    }
  }

  DateFormat formatter = DateFormat.yMd();
  DateTime? _selectedDate;
  Category currentCategory = Category.lifeStyle;
  RateCount currentRate = RateCount.daily;
  late String title;
  late int count;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        height: 900,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                onChanged: (value) {
                  setState(() {
                    title = value;
                  });
                },
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    labelText: "Title", labelStyle: TextStyle(fontSize: 14)),
              ),
              Row(
                children: [
                  SizedBox(
                      width: 120,
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            count = int.parse(value);
                          });
                        },
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            labelText: "Count",
                            suffixText: "times",
                            labelStyle: TextStyle(fontSize: 14)),
                      )),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(_selectedDate == null
                              ? "No Selected Date "
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
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DropdownButton(
                    alignment: Alignment.center,
                    value: currentCategory,
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
                  DropdownButton(
                    alignment: Alignment.center,
                    value: currentRate,
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
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Close"),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Add New Task"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
