import 'package:expense_tracker/repository/screens/homescreen/homescreen.dart';
import 'package:flutter/material.dart';

class Createexpense extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CreateexpenseState();
}

class CreateexpenseState extends State<Createexpense> {
  DateTime? _selectedDate;
  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  final TextEditingController titlecontroller = TextEditingController();
  final TextEditingController expensecontroller = TextEditingController();

  @override
  void dispose() {
    titlecontroller.dispose();
    expensecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF7B68EE), // Medium slate blue
              Color(0xFF9370DB), // Medium purple
              Color.fromARGB(255, 110, 79, 184), // Medium orchid
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 370,
              height: 70,
              child: TextField(
                controller: titlecontroller,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 165, 192, 213),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: "Title",
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(width: 18),
                SizedBox(
                  width: 150,
                  height: 70,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: expensecontroller,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(255, 165, 192, 213),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      labelText: "Amount",
                      prefixIcon: Icon(Icons.currency_rupee),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  _selectedDate == null
                      ? "Select a date"
                      : "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}",
                  style: TextStyle(fontSize: 18),
                ),
                IconButton(
                  icon: Icon(Icons.calendar_today, color: Colors.blue),
                  onPressed: _pickDate,
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final int expenseValue =
                    int.tryParse(expensecontroller.text) ?? 0;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => Homescreen(
                          title: titlecontroller.text,
                          expense: expenseValue,
                          date: _selectedDate!,
                        ),
                  ),
                );
              },
              child: Text("Sumbit"),
            ),
          ],
        ),
      ),
    );
  }
}
