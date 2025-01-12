import 'package:flutter/material.dart';
import '../helpers/planning_helper.dart';

class RencanaProvider with ChangeNotifier {
  List<dynamic> _plans = [];
  bool _isLoading = true;
  String? _error;

  List<dynamic> get plans => _plans;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadPlans() async {
    try {
      _isLoading = true;
      notifyListeners(); // Notify listeners before starting data fetch

      // Replace with your actual data loading logic, for example:
      final fetchedPlans = await PlanningHelper().fetchPlans();
      _plans = fetchedPlans;// Use an appropriate method to fetch your plans
      _isLoading = false;
      notifyListeners(); // Notify listeners when data is loaded
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners(); // Notify listeners if there's an error
    }
  }
}
