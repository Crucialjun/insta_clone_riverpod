import 'package:flutter/material.dart';
import 'package:insta_clon_rivrpo/state/views/components/rich_text/base_text.dart';
import 'package:insta_clon_rivrpo/state/views/components/rich_text/rich_text_widget.dart';
import 'package:insta_clon_rivrpo/state/views/constants/strings.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginViewSignupLink extends StatelessWidget {
  const LoginViewSignupLink({super.key});

  @override
  Widget build(BuildContext context) {
    return RichTextWidget(
        styleForAll:
            Theme.of(context).textTheme.titleMedium?.copyWith(height: 1.5),
        texts: [
          BaseText.plain(text: Strings.dontHaveAnAccount),
          BaseText.plain(text: Strings.signUpOn),
          BaseText.link(
              text: Strings.facebook,
              onTap: () {
                launchUrl(Strings.facebookUrl.);
              }),
        ]);
  }
}
