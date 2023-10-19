import 'package:bookme/core/presentation/theme/primary_color.dart';
import 'package:bookme/core/presentation/utitls/app_padding.dart';
import 'package:bookme/core/presentation/widgets/animated_column.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../app_button.dart';
class UnauthorizedIndicator extends StatelessWidget {
  const UnauthorizedIndicator({
    required this.onPressed,
    super.key});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPaddings.bodyA,
      child: Center(
          child: AppAnimatedColumn(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  <Widget>[
              const CircleAvatar(
                backgroundColor: PrimaryColor.color,
                  radius: 40,
                  child: Icon(Ionicons.lock_closed_outline,
                  color: Colors.white,
                  size: 30,),
              ),
              const Text('Sign In Easier',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20
              ),),
              const Text('Sorry you need to sign in to view this page'),
              AppButton(onPressed: onPressed,
                padding: AppPaddings.mA,
                text: 'Sign in',
              ),
            ],
          ),
      ),
    );
  }
}

