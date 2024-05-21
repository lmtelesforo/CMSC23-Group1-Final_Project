import 'package:cmsc23_project/models/organization.dart';
import 'package:cmsc23_project/org-view/base_screen.dart';
import 'package:cmsc23_project/org-view/org_view_styles.dart';
import 'package:cmsc23_project/providers/current_org_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    Organization org = context.read<CurrentOrgProvider>().currentOrg;

    return BaseScreen(
      body: Center(
        child: Column(
          children: [
            _bigAvatar,
            Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(org.name, style: CustomTextStyle.h1)),
            _about(org),
          ],
        ),
      ),
    );
  }

  Widget get _bigAvatar => Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 7,
              ),
            ),
            child: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile_pic.jpg'),
              radius: 50,
              backgroundColor: Colors.white,
            ),
          ),
          Positioned(
            bottom: 2,
            right: 2,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: CustomColors.primary,
              ),
              child: Container(
                padding: const EdgeInsets.all(5),
                child: const Icon(
                  Icons.edit,
                  color: CustomColors.secondary,
                ),
              ),
            ),
          ),
        ],
      );

  Widget _about(org) => Container(
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: [
            Card(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: const Text("About", style: CustomTextStyle.h2),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        bottom: 10,
                      ),
                      child: Text(org.about, style: CustomTextStyle.body),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: Row(
                        children: [
                          if (org.openForDonations) ...[
                            const Icon(Icons.check, color: Colors.green),
                            const Padding(
                              padding: EdgeInsets.only(left: 5.0),
                              child: Text(
                                "Open for donations",
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                          ] else ...[
                            const Icon(Icons.close, color: Colors.red),
                            const Padding(
                              padding: EdgeInsets.only(left: 5.0),
                              child: Text(
                                "Closed for donations",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ]
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: CustomColors.primary,
                ),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: const Icon(
                    Icons.edit,
                    color: CustomColors.secondary,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
