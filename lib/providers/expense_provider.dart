// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/expense_model.dart';

class ExpensesNotifier extends StateNotifier<List<Expense>> {
  ExpensesNotifier() : super([]);

  void addExpense(Expense expense) {
    state = [...state, expense];
  }

  void removeExpense(int index) {
    state = [...state]..removeAt(index);
  }
}

final expensesProvider = StateNotifierProvider<ExpensesNotifier, List<Expense>>(
  (ref) {
    return ExpensesNotifier();
  },
);
