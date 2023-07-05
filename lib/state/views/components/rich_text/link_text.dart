import 'package:flutter/material.dart';
import 'package:insta_clon_rivrpo/state/views/components/rich_text/base_text.dart';

@immutable
class LinkText extends BaseText {
  final VoidCallback onTap;

  const LinkText({required String text, required this.onTap, TextStyle? style})
      : super(text: text, style: style);
}
