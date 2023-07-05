import 'package:flutter/material.dart';
import 'package:insta_clon_rivrpo/state/views/components/rich_text/link_text.dart';

@immutable
class BaseText {
  final String text;
  final TextStyle? style;

  const BaseText({required this.text, this.style});

  factory BaseText.plain(
          {required String text, TextStyle? style = const TextStyle()}) =>
      BaseText(text: text, style: style);

  factory BaseText.link(
          {required String text,
          required VoidCallback onTap,
          TextStyle? style = const TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.blue,
              fontWeight: FontWeight.bold)}) =>
      LinkText(text: text, style: style, onTap: onTap);
}
