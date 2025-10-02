import 'package:expense_tracker/repository/screens/createexpense/createexpense.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  final String title;
  final int expense;
  final DateTime date;
  const Homescreen({
    super.key,
    required this.expense,
    required this.title,
    required this.date,
  });
  @override
  State<StatefulWidget> createState() => HomescreenState();
}

class HomescreenState extends State<Homescreen> {
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
            Container(
              height: 200,
              width: 300,
              color: const Color.fromARGB(255, 246, 247, 248),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(widget.title),
                      trailing: Text(widget.expense.toString()),
                      subtitle: Text(
                        "${widget.date.day}/${widget.date.month}/${widget.date.year}",
                      ),
                    ),
                  );
                },
                itemCount: 3,
              ),
            ),
            SizedBox(height: 20),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Createexpense()),
                );
              },
              icon: Icon(Icons.add),
              color: Colors.blue,
              iconSize: 100,
            ),
          ],
        ),
      ),
    );
  }
}
