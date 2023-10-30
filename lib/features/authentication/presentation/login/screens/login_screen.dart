import 'package:bookme/core/presentation/widgets/app_button.dart';
import 'package:bookme/core/presentation/widgets/app_loading_box.dart';
import 'package:bookme/features/authentication/presentation/login/getx/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/utitls/app_spacing.dart';
import '../../../../../core/presentation/widgets/animated_column.dart';
import '../../../../../core/presentation/widgets/app_text_input_field.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => AppLoadingBox(
          loading: controller.isLoading.value,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: <Widget>[
                _buildHeaderContainer(context),
                _buildForm(context),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text("Don't have an account?"),
              TextButton(
                onPressed: () {},
                child: const Text('Register'),
              )
            ],
          )),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10.0),
      child: AppAnimatedColumn(
        children: <Widget>[
          AppTextInputField(
            labelText: 'Email',
            hintText: 'user@mail.com',
            onChanged: controller.onEmailInputChanged,
            validator: controller.validateEmail,
            maxLines: 1,
            textInputType: TextInputType.emailAddress,
          ),
          const AppSpacing(
            v: 10,
          ),
          Obx(
            () => AppTextInputField(
              maxLines: 1,
              labelText: 'Password',
              onChanged: controller.onPasswordInputChanged,
              validator: controller.validatePassword,
              obscureText: !controller.showPassword.value,
              suffixIcon: AnimatedSwitcher(
                reverseDuration: Duration.zero,
                transitionBuilder:
                    (Widget? child, Animation<double> animation) {
                  final Animation<double> offset =
                      Tween<double>(begin: 0, end: 1.0).animate(animation);
                  return ScaleTransition(scale: offset, child: child);
                },
                switchInCurve: Curves.elasticOut,
                duration: const Duration(milliseconds: 700),
                child: IconButton(
                  key: ValueKey<bool>(controller.showPassword.value),
                  onPressed: controller.togglePassword,
                  icon: Obx(
                    () => controller.showPassword.value
                        ? const Icon(
                            Icons.visibility,
                            size: 20,
                          )
                        : const Icon(
                            Icons.visibility_off,
                            size: 20,
                          ),
                  ),
                ),
              ),
            ),
          ),
          const AppSpacing(
            v: 20,
          ),
          Obx(
            () => AppButton(
              onPressed: () => controller.login(context),
              text: 'Login',
              padding: const EdgeInsets.all(10),
              enabled: controller.formIsValid.value,
            ),
          ),
        ],
      ),
    );
  }

  Container _buildHeaderContainer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color(0xFF141D1C),
            Color(0xFF111818),
            Color(0xFF0D1413),
            Color(0xFF070B0B),
          ],
          stops: <double>[0.0, 0.25, 0.5, 0.75],
          // Corresponding to the color stops
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Sign in to your \nAccount',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Sign in to your account',
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
