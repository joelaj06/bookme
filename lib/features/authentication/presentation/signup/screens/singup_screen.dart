import 'package:bookme/core/presentation/theme/primary_color.dart';
import 'package:bookme/core/presentation/utitls/app_assets.dart';
import 'package:bookme/core/presentation/utitls/app_padding.dart';
import 'package:bookme/core/presentation/utitls/app_spacing.dart';
import 'package:bookme/features/authentication/presentation/signup/getx/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      backgroundColor: PrimaryColor.color,
      bottomNavigationBar: Container(
        height: 50,
        color: Colors.white,
        child: const Center(
          child: Text('Choose an account to continue'),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  AppImageAssets.labourBg,
                ),
                fit: BoxFit.cover)),
        child: Padding(
          padding: AppPaddings.mA,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildUserTypeCard(context,
                  image: AppImageAssets.client, desc: 'Client', isAgent: false),
              const AppSpacing(
                v: 50,
              ),
              const Divider(
                height: 3,
                color: Colors.white,
                thickness: 5,
              ),
              const AppSpacing(
                v: 50,
              ),
              _buildUserTypeCard(context,
                  image: AppImageAssets.plumber, desc: 'Agent', isAgent: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserTypeCard(BuildContext context,
      {required String image, required String desc, required bool isAgent}) {
    return GestureDetector(
      onTap: () => controller.onAccountTypeSelected(context, isAgent),
      child: SizedBox(
        child: Padding(
          padding: AppPaddings.sA,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: AppPaddings.mA,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.white,
                      child: Image.asset(image, fit: BoxFit.contain),
                    ),
                  ),
                ),
              ),
              Container(
                padding: AppPaddings.mA,
                decoration: BoxDecoration(boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ], color: Colors.white, borderRadius: BorderRadius.circular(5)),
                child: Text(
                  desc.toUpperCase(),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
