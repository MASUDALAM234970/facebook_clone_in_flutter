import 'dart:io';

import 'package:facebook_clone_in_flutter/core/constants/app_colors.dart';
import 'package:facebook_clone_in_flutter/core/widgets/pick_image_widget.dart';
import 'package:facebook_clone_in_flutter/core/widgets/round_button.dart';
import 'package:facebook_clone_in_flutter/core/widgets/round_text_field.dart';
import 'package:facebook_clone_in_flutter/features/auth/presentation/widgets/birthday_picker.dart';
import 'package:facebook_clone_in_flutter/features/auth/presentation/widgets/gender_radio_tile.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/utils.dart';
import '../../utils/utils.dart';
import '/core/constants/constants.dart';

final _formKey = GlobalKey<FormState>();

class CreateAccountScreen extends StatefulWidget {
  static const routeName = '/create-account';
  const CreateAccountScreen({super.key});


  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  File? image;
  DateTime? birthday;
  String gender = 'male';
  bool isLoading = false;

  // controllers
  late final TextEditingController _fNameController;
  late final TextEditingController _lNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _fNameController = TextEditingController();
    _lNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _fNameController.dispose();
    _lNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
                GestureDetector(
                    onTap: () async {
                      image = await pickImage();
                      setState(() {});
                    },
                    child: PickImageWidget(image: image)),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: RoundTextField(
                        controller: _fNameController,
                        hintText: 'First Name',
                        textInputAction: TextInputAction.next,
                        validator: validateName,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: RoundTextField(
                        controller: _lNameController,
                        hintText: 'Last Name',
                        textInputAction: TextInputAction.next,
                        validator: validateName,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                BirthdayPicker(
                  dateTime: birthday ?? DateTime.now(),
                  onPressed: () async {
                    birthday = await pickSimpleDate(
                      context: context,
                      date: birthday,
                    );
                    setState(() {});
                  },
                ),
                const SizedBox(height: 20),
                GenderPicker(
                  gender: gender,
                  onChanged: (value) {
                    gender = value ?? 'male';
                    setState(() {});
                  },
                ),
                const SizedBox(height: 20),
                RoundTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  validator: validateEmail,
                ),
                const SizedBox(height: 20),

                const SizedBox(height: 20),
                RoundButton(
                  onPressed: () {},
                  label: "Create Account",
                )
              ],
            ),
          ),
        ),
      ),
    ); // <-- ✅ This closes Scaffold
  }
}
