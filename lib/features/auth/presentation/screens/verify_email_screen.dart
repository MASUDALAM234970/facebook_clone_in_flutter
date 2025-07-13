import 'package:facebook_clone_in_flutter/core/constants/constants.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/round_button.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: Constants.defaultPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundButton(onPressed: () {}, label: "Verify Email"),
            const SizedBox(height: 20),
            RoundButton(onPressed: () {}, label: "Refresh"),
            const SizedBox(height: 20),
            RoundButton(onPressed: () {}, label: "Change Email"),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
