// ignore_for_file: avoid_types_as_parameter_names

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardController extends GetxController {
  var sales = 0.0.obs;
  var payments = 0.0.obs;
  var purchases = 0.0.obs;
  var expenses = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDashboardData();
  }

  void fetchDashboardData() async {
    try {
      // Fetch sales data
      final salesSnapshot =
          await FirebaseFirestore.instance.collection('sales').get();
      sales.value =
  
          salesSnapshot.docs.fold(0.0, (sum, doc) => sum + doc['amount']);

      // Fetch payments data
      final paymentsSnapshot =
          await FirebaseFirestore.instance.collection('payments').get();
      payments.value =
          paymentsSnapshot.docs.fold(0.0, (sum, doc) => sum + doc['amount']);

      // Fetch purchases data
      final purchasesSnapshot =
          await FirebaseFirestore.instance.collection('purchases').get();
      purchases.value =
          purchasesSnapshot.docs.fold(0.0, (sum, doc) => sum + doc['amount']);

      // Fetch expenses data
      final expensesSnapshot =
          await FirebaseFirestore.instance.collection('expenses').get();
      expenses.value =
          expensesSnapshot.docs.fold(0.0, (sum, doc) => sum + doc['amount']);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch dashboard data');
    }
  }
}
