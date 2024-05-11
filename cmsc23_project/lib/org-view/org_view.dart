import 'package:cmsc23_project/org-view/base_view.dart';
import 'package:flutter/material.dart';

class OrgHomePage extends StatelessWidget {
  const OrgHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
      body: Column(
        children: [
          mainAction(context),
        ],
      ),
    );
  }

  Widget mainAction(context) => Container(
        padding: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Card(
            child: InkWell(
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        'Organize your donation drives',
                        style: CustomTextStyle.main,
                      ),
                    ),
                    Image(
                      image: AssetImage('assets/images/xmas_box.png'),
                      height: 80,
                      width: 80,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}

class CustomTextStyle {
  static const main = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
}
