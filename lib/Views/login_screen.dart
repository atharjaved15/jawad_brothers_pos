import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jawad_brothers_pos/Constants/Strings.dart';
import 'package:jawad_brothers_pos/Constants/app_paddings.dart';
import 'package:jawad_brothers_pos/Constants/colors.dart';
import 'package:jawad_brothers_pos/Constants/styles.dart';
import 'package:jawad_brothers_pos/Controllers/login_controller.dart';
import 'package:jawad_brothers_pos/Widgets/custom_button_widget.dart';

class LoginView extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  LoginView({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Determine whether the screen width is considered mobile
    bool isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Row(
        children: [
          // Left side for the form
          Expanded(
            flex: 1,
            child: Padding(
              padding: AppPadding.screenPadding,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isMobile) ...[
                        const Center(
                          child: Column(
                            children: [
                              Icon(Icons.security,
                                  size: 100,
                                  color: AppColors
                                      .primaryColor), // Replace with your logo
                              SizedBox(height: 20),
                              Text(
                                AppStrings.companyName,
                                style: AppTextStyles.companyNameTextStyle,
                              ),
                              SizedBox(height: 10),
                              Text(
                                AppStrings.rightsReserved,
                                style: AppTextStyles.rightsReservedTextStyle,
                              ),
                              SizedBox(height: 30),
                            ],
                          ),
                        ),
                      ],
                      const Text(
                        AppStrings.welcomeText,
                        style: AppTextStyles.welcomeTextStyle,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        AppStrings.loginPrompt,
                        style: AppTextStyles.promptTextStyle,
                      ),
                      const SizedBox(height: 30),
                      _buildTextField(AppStrings.emailHint, emailController),
                      const SizedBox(height: 20),
                      _buildTextField(
                          AppStrings.passwordHint, passwordController,
                          obscureText: true),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          text: AppStrings.loginButton,
                          onPressed: () {
                            // Debugging print to check button functionality
                            debugPrint("Login button pressed");

                            authController.login(
                              emailController.text.trim(),
                              passwordController.text.trim(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Right side for the logo (only visible on larger screens)
          if (!isMobile)
            Expanded(
              flex: 1,
              child: Container(
                color: AppColors.secondaryColor,
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo Widget
                      Icon(Icons.security,
                          size: 100,
                          color:
                              AppColors.primaryColor), // Replace with your logo
                      SizedBox(height: 20),
                      Text(
                        AppStrings.companyName,
                        style: AppTextStyles.companyNameTextStyle,
                      ),
                      SizedBox(height: 10),
                      Text(
                        AppStrings.rightsReserved,
                        style: AppTextStyles.rightsReservedTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTextField(String hintText, TextEditingController controller,
      {bool obscureText = false}) {
    return MouseRegion(
      cursor: SystemMouseCursors.text,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: AppColors.primaryColor,
              width: 2,
            ),
          ),
          hoverColor: Colors.grey[300],
          fillColor: Colors.grey[200],
        ),
      ),
    );
  }
}
