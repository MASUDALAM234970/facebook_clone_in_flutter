import 'package:facebook_clone_in_flutter/core/constants/constants.dart';
import 'package:facebook_clone_in_flutter/core/widgets/round_button.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/round_text_field.dart';
import '../../utils/utils.dart';

final _formkey = GlobalKey<FormState>();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  bool isLoading = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: Constants.defaultPadding,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/icons/fb_logo.png',
              width: 60,
            ),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  RoundTextField(
                    controller: _emailController,
                    hintText: 'Email',
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    validator: validateEmail,
                  ),
                  const SizedBox(height: 15),
                  RoundTextField(
                    controller: _passwordController,
                    hintText: 'Password',
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.visiblePassword,
                    validator: validatePassword,
                  ),
                  const SizedBox(height: 15),
                  RoundButton(onPressed: () {}, label: 'Login'),
                  const SizedBox(height: 15),
                  const Text(
                    'Forget password?',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ) ,Column(
              children: [
                RoundButton(onPressed: () {}, label: "Create New Account",
                  color: Colors.transparent,),
                const SizedBox(height: 10),
                Image.asset(
                  'assets/icons/meta.png',
                  height: 50,
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}
