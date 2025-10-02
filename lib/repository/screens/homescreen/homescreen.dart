import 'package:expense_tracker/providers/expense_provider.dart';
import 'package:expense_tracker/repository/screens/createexpense/createexpense.dart';
import 'package:expense_tracker/widgets/category_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'expense_model.dart';
// import 'providers.dart';

class Homescreen extends ConsumerWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenses = ref.watch(expensesProvider);
    // var amount = 0;

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 171, 244, 125),
              Color.fromARGB(255, 174, 247, 132),
              Color.fromARGB(255, 158, 249, 157),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 60),
            Text(
              "EXPENSE TRACKER",
              style: TextStyle(
                color: Colors.black,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40),
            Container(
              height: 300,
              padding: const EdgeInsets.all(12),
              child: const CategoryChart(),
            ),
            const SizedBox(height: 20),
            Expanded(
              child:
                  expenses.isEmpty
                      ? Text(
                        "No expenses yet..",
                        style: TextStyle(fontSize: 30),
                      )
                      : ListView.builder(
                        itemCount: expenses.length,
                        itemBuilder: (context, index) {
                          final expense = expenses[index];
                          return Dismissible(
                            key: Key(expense.hashCode.toString()),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              // refresh using riverpod
                              ref
                                  .read(expensesProvider.notifier)
                                  .removeExpense(index);
                            },
                            child: Card(
                              margin: EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              color: const Color.fromARGB(255, 78, 77, 77),
                              child: ListTile(
                                title: Text(
                                  expense.title,
                                  style: TextStyle(color: Colors.white),
                                ),
                                trailing: Text(
                                  "₹${expense.amount}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                                subtitle: Text(
                                  "${expense.date.day}/${expense.date.month}/${expense.date.year}",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                height: 70,
                width: 250,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 78, 77, 77),
                  ),

                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Createexpense(),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.add, size: 30, color: Colors.white),
                      SizedBox(width: 20),
                      Text(
                        "Add your expense",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 17, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
