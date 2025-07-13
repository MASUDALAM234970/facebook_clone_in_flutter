import 'package:facebook_clone_in_flutter/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

import '/core/constants/constants.dart';
final _formKey = GlobalKey<FormState>();
class CreateAccountScreee extends StatefulWidget {
  const CreateAccountScreee({super.key});

  @override
  State<CreateAccountScreee> createState() => _CreateAccountScreeeState();
}

class _CreateAccountScreeeState extends State<CreateAccountScreee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.realWhiteColor,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: Constants.defaultPadding,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text("Hello"),
              ],
            ),
          ),
        ),
      ),
    ); // <-- ✅ This closes Scaffold
  }

}
