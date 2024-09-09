// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jawad_brothers_pos/Constants/Strings.dart';
import 'package:jawad_brothers_pos/Constants/colors.dart';
import 'package:jawad_brothers_pos/Constants/styles.dart';
import 'package:jawad_brothers_pos/Controllers/dashboard_controller.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final RxString selectedItem = 'Dashboard'.obs;
  final RxString selectedSubItem = ''.obs; // To track selected sub-item
  final DashboardController dashboardController =
      Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Row(
        children: [
          _buildSidebar(),
          Expanded(
            child: Obx(() {
              return _getSelectedScreen(
                  selectedItem.value, selectedSubItem.value, context);
            }),
          ),
        ],
      ),
      drawer: isMobile(context) ? Drawer(child: _buildSidebar()) : null,
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Text(
              DateFormat('dd MMM, yyyy - hh:mm a').format(DateTime.now()),
              style: const TextStyle(color: Colors.white70),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.blue,
            backgroundColor: AppColors.primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text('POS'),
        ),
        PopupMenuButton<String>(
          onSelected: (String result) {},
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'Owner',
              child: Text('Owner'),
            ),
            const PopupMenuItem<String>(
              value: 'Logout',
              child: Text('Logout'),
            ),
          ],
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CircleAvatar(
              backgroundColor: Colors.blue[200],
              child: const Icon(Icons.person, color: Colors.white),
            ),
          ),
        ),
      ],
      backgroundColor: Colors.white,
      elevation: 0,
      leading: isMobile(context)
          ? IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            )
          : null,
      title: const Text(
        AppStrings.companyName,
        style: AppTextStyles.companyNameTextStyle,
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 250,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSidebarItem('Dashboard', Icons.dashboard),
            _buildExpansionTile(
              'Items',
              Icons.list_alt,
              [
                _buildSubMenuItem('Products'),
                _buildSubMenuItem('Categories'),
                _buildSubMenuItem('Brands'),
                _buildSubMenuItem('Units'),
                _buildSubMenuItem('Discounts'),
                _buildSubMenuItem('Taxes'),
              ],
            ),
            _buildExpansionTile(
              'Sales',
              Icons.sell,
              [
                _buildSubMenuItem('Sales'),
                _buildSubMenuItem('Quotation'),
              ],
            ),
            _buildExpansionTile(
              'Returns',
              Icons.keyboard_return,
              [
                _buildSubMenuItem('Sales Returns'),
                _buildSubMenuItem('Purchase Returns'),
              ],
            ),
            _buildExpansionTile(
              'Expenses',
              Icons.money,
              [
                _buildSubMenuItem('Expenses'),
                _buildSubMenuItem('Categories'),
              ],
            ),
            _buildSidebarItem('Staff Members', Icons.people),
            _buildSidebarItem('Customers', Icons.person),
            _buildSidebarItem('Suppliers', Icons.local_shipping),
            _buildSidebarItem('Purchases', Icons.shopping_cart),
            _buildSidebarItem('Reports', Icons.bar_chart),
            _buildSidebarItem('Warehouses', Icons.warehouse),
            _buildSidebarItem('Inventory', Icons.inventory_2),
            _buildSidebarItem('Settings', Icons.settings),
          ],
        ),
      ),
    );
  }

  Widget _buildSidebarItem(String title, IconData icon) {
    return Obx(() {
      bool isSelected = selectedItem.value == title;

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: ElevatedButton(
          onPressed: () {
            selectedItem.value = title;
            selectedSubItem.value =
                ''; // Reset the sub-item when a main item is selected
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: isSelected ? Colors.white : Colors.black,
            backgroundColor: isSelected ? AppColors.primaryColor : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          ),
          child: Row(
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Icon(icon, color: Colors.black),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildExpansionTile(
      String title, IconData icon, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          iconColor: Colors.black,
          collapsedIconColor: Colors.black,
          title: Row(
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Icon(icon, color: Colors.black),
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          children: children,
        ),
      ),
    );
  }

  Widget _buildSubMenuItem(String title) {
    return Obx(() {
      bool isSelected = selectedSubItem.value == title;

      return ListTile(
        title: Text(
          title,
          style: TextStyle(
              color: isSelected ? AppColors.primaryColor : Colors.black),
        ),
        leading: Icon(
          Icons.circle,
          size: 8,
          color: isSelected ? AppColors.primaryColor : Colors.black,
        ),
        onTap: () {
          selectedItem.value =
              title.split(' ')[0]; // Main item remains selected
          selectedSubItem.value = title;
          if (isMobile(context)) Get.back(); // Close the drawer on mobile
        },
      );
    });
  }

  Widget _getSelectedScreen(
      String selectedScreen, String selectedSubScreen, BuildContext context) {
    // Modify to display different content based on selectedScreen and selectedSubScreen
    if (selectedSubScreen.isNotEmpty) {
      return Center(child: Text('$selectedSubScreen Screen'));
    } else {
      return Center(child: Text('$selectedScreen Screen'));
    }
  }

  Widget _buildDashboardContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.grey[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Dashboard",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: isMobile(context)
                  ? 1
                  : 4, // 1 column on mobile, 4 on larger screens
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: isMobile(context)
                  ? 2
                  : 1, // Adjust the aspect ratio for mobile
              children: [
                Obx(() => _buildDashboardCard(
                      color: Colors.blue,
                      icon: Icons.shopping_cart,
                      title: "Sales",
                      value: "Rs ${dashboardController.sales}",
                      date: "Jan 1, 2024 - Dec 31, 2024",
                      context: context,
                    )),
                Obx(() => _buildDashboardCard(
                      color: Colors.pink,
                      icon: Icons.payment,
                      title: "Payments",
                      value: "Rs ${dashboardController.payments}",
                      date: "Jan 1, 2024 - Dec 31, 2024",
                      context: context,
                    )),
                Obx(() => _buildDashboardCard(
                      color: Colors.orange,
                      icon: Icons.receipt,
                      title: "Purchases",
                      value: "Rs ${dashboardController.purchases}",
                      date: "Jan 1, 2024 - Dec 31, 2024",
                      context: context,
                    )),
                Obx(() => _buildDashboardCard(
                      color: Colors.red,
                      icon: Icons.money_off,
                      title: "Expenses",
                      value: "Rs ${dashboardController.expenses}",
                      date: "Jan 1, 2024 - Dec 31, 2024",
                      context: context,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardCard({
    required Color color,
    required IconData icon,
    required String title,
    required String value,
    required String date,
    required BuildContext context,
  }) {
    double fontSize = isMobile(context) ? 14 : 20;
    double iconSize = isMobile(context) ? 24 : 30;

    return Card(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.white, size: iconSize),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSize + 6,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              date,
              style: TextStyle(
                color: Colors.white70,
                fontSize: fontSize - 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }
}
