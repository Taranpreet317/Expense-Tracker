import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/expense_provider.dart';

class CategoryChart extends ConsumerWidget {
  const CategoryChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenses = ref.watch(expensesProvider);

    // Group by category
    final Map<String, int> categoryTotals = {};
    for (var expense in expenses) {
      categoryTotals[expense.category] =
          (categoryTotals[expense.category] ?? 0) + expense.amount;
    }

    final total = categoryTotals.values.fold(0, (sum, e) => sum + e);

    // if (total == 0) {
    //   return const Center(child: Text("No expenses yet"));
    // }

    return PieChart(
      PieChartData(
        sections:
            categoryTotals.entries.map((entry) {
              final percentage = (entry.value / total * 100).toStringAsFixed(1);
              return PieChartSectionData(
                value: entry.value.toDouble(),
                title: "${entry.key}\n$percentage%",
                color: _getCategoryColor(entry.key),
                radius: 80,
                titleStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              );
            }).toList(),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Food":
        return Colors.orange;
      case "Travel":
        return Colors.blue;
      case "Movies":
        return Colors.red;
      case "Shopping":
        return Colors.purple;
      default:
        return Colors.green;
    }
  }
}
