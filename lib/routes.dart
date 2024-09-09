import 'package:get/get.dart';
import 'package:jawad_brothers_pos/Views/dashboard.dart';
import 'package:jawad_brothers_pos/Views/login_screen.dart'; // Create this later

class AppRoutes {
  static const String login = '/login';
  static const String dashboard = '/dashboard';

  static List<GetPage> pages = [
    GetPage(name: login, page: () => LoginView()),
    GetPage(name: dashboard, page: () => const DashboardView()),
    // Placeholder, create HomeView later
  ];
}
