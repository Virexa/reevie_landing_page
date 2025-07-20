import 'package:flutter/cupertino.dart';

extension ContextExtension on BuildContext {
  Size get mSize => MediaQuery.sizeOf(this);

  double get mH => MediaQuery.sizeOf(this).height;

  double get mW => MediaQuery.sizeOf(this).width;
}
