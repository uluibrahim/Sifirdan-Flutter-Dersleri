import 'dart:io';

import 'package:flutter/material.dart';

abstract class PlatformDuyarliWidget extends StatelessWidget {
  Widget buildAndroidWidget(BuildContext context);
  Widget builIOSWidget(BuildContext context);
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? builIOSWidget(context)
        : buildAndroidWidget(context);
  }
}
