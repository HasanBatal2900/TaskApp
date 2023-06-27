import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Model/Task.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  @override
  DateFormat formatter = DateFormat.yMd();
  DateTime? _selectedDate;
  Category currentCategory = Category.lifeStyle;
  RateCount currentRate = RateCount.daily;
  String? _selectedTitle;
  int _selectedCount = 0;

  TextEditingController _countController = TextEditingController();

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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 130,
        flexibleSpace: ClipPath(
          clipper: MyCustomClip(),
          child: Container(
            padding: const EdgeInsets.only(top: 10),
            alignment: Alignment.center,
            height: 200,
            color: const Color.fromARGB(255, 92, 56, 154),
            child: const  Text(
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
            TextField(
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
            Row(
              children: [
                SizedBox(
                    width: 120,
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _countController.text = value;
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
