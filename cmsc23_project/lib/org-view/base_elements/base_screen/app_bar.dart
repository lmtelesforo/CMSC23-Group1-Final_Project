import 'package:cmsc23_project/org-view/base_elements/org_view_styles.dart';
import 'package:flutter/material.dart';

class OrgAppBar {
  final List<Widget>? actions;

  const OrgAppBar({this.actions});

  AppBar get appBar => AppBar(
        iconTheme: const IconThemeData(
          color: CustomColors.primary,
        ),
        backgroundColor: Colors.transparent,
        title: _logo,
        centerTitle: true,
        actions: actions,
      );

  Widget get _logo => const Image(
        image: AssetImage('assets/images/cmsc23_logo1.png'),
        height: 50,
        width: 50,
      );
}
