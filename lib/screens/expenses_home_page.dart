import 'package:flutter/material.dart';
import 'add_expense_page.dart';
import '../models/expense.dart';

class ExpensesHomePage extends StatefulWidget {
  const ExpensesHomePage({super.key});

  @override
  State<ExpensesHomePage> createState() => _ExpensesHomePageState();
}

class _ExpensesHomePageState extends State<ExpensesHomePage> {
  // This cannot be final because we modify it
  List<Expense> _expenses = [
    Expense(id: '1', title: 'Groceries', amount: 75.50),
    Expense(id: '2', title: 'Electric Bill', amount: 120.00),
    Expense(id: '3', title: 'Internet Subscription', amount: 45.99),
  ];

  Future<void> _navigateToAddExpense() async {
    final Expense? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddExpensePage(),
      ),
    );

    if (!mounted) return;

    if (result != null) {
      setState(() {
        _expenses.add(result);
      });

      _showSnackBar('Added: ${result.title}', Colors.green);
    }
  }

  Future<void> _navigateToEditExpense(Expense expense) async {
    final Expense? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddExpensePage(expense: expense),
      ),
    );

    if (!mounted) return;

    if (result != null) {
      setState(() {
        final index = _expenses.indexWhere((e) => e.id == result.id);
        if (index != -1) {
          _expenses[index] = result;
        }
      });

      _showSnackBar('Updated: ${result.title}', Colors.blue);
    }
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  String _formatPeso(double amount) {
    return '₱ ${amount.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        backgroundColor: Colors.grey[50],
        elevation: 0,
      ),
      body: _expenses.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.receipt_long, size: 80, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  const Text(
                    'No expenses yet', 
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap the + button to add your first expense',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _expenses.length,
              itemBuilder: (context, index) {
                final expense = _expenses[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.receipt, color: Colors.blue[700]),
                    ),
                    title: Text(
                      expense.title, 
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: const Text('Tap to edit'),
                    trailing: Text(
                      _formatPeso(expense.amount),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.blue[700],
                      ),
                    ),
                    onTap: () => _navigateToEditExpense(expense),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddExpense(),
        backgroundColor: Colors.blue[600],
        child: const Icon(Icons.add),
      ),
    );
  }
}