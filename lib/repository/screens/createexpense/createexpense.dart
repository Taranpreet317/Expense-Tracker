import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/providers/expense_provider.dart';
import 'package:expense_tracker/repository/screens/homescreen/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

// Providers
final selectedDateProvider = StateProvider<DateTime?>((ref) => null);
final categories = ["Food", "Travel", "Movies", "Shopping", "Other"];
final categoryProvider = StateProvider<String>((ref) => "Other");

class Createexpense extends ConsumerWidget {
  const Createexpense({super.key});

  Future<void> _pickDate(BuildContext context, WidgetRef ref) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      ref.read(selectedDateProvider.notifier).state = picked;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);

    final titleController = TextEditingController();
    final expenseController = TextEditingController();

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
            Text(
              "Add your Expenses",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 40,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 20),
            Icon(Icons.receipt_long, size: 50),

            SizedBox(height: 100),
            SizedBox(
              width: 370,
              height: 70,
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: "Title",
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(width: 18),
                SizedBox(
                  width: 150,
                  height: 70,
                  child: TextField(
                    controller: expenseController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(255, 255, 255, 255),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      labelText: "Amount",
                      prefixIcon: const Icon(Icons.currency_rupee),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  selectedDate == null
                      ? "Select a date"
                      : "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                  style: const TextStyle(fontSize: 18),
                ),
                IconButton(
                  icon: const Icon(Icons.calendar_today, color: Colors.blue),
                  onPressed: () => _pickDate(context, ref),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 370,
              child: DropdownButtonFormField<String>(
                value: ref.watch(categoryProvider),
                items:
                    categories.map((cat) {
                      return DropdownMenuItem(value: cat, child: Text(cat));
                    }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    ref.read(categoryProvider.notifier).state = value;
                  }
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: "Category",
                ),
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              height: 70,
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  final selectedDate = ref.read(selectedDateProvider);
                  final title = titleController.text;
                  final expense = int.parse(expenseController.text);
                  final category = ref.read(categoryProvider);
                  if (selectedDate != null && title.isNotEmpty && expense > 0) {
                    ref
                        .read(expensesProvider.notifier)
                        .addExpense(
                          Expense(
                            title: title,
                            amount: expense,
                            date: selectedDate,
                            category: category,
                          ),
                        );

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Homescreen(),
                      ),
                    );
                  }
                },
                child: const Text("Submit", style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
