import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23_project/models/org_signup.dart';
import 'package:cmsc23_project/org-view/base_elements/base_screen/base_screen.dart';
import 'package:cmsc23_project/org-view/base_elements/org_view_styles.dart';
import 'package:cmsc23_project/providers/current_org_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> org = context.read<CurrentOrgProvider>().currentOrg;

    return BaseScreen(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/org/profile/edit');
        },
        child: const Icon(Icons.edit),
      ),
      body: Center(
        child: StreamBuilder(
          stream: org,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Error');
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            Org org = Org.fromJson(
                snapshot.data!.docs.first.data() as Map<String, dynamic>);

            return profile(org);
          },
        ),
      ),
    );
  }

  Column profile(Org org) {
    return Column(
      children: [
        _bigAvatar(org),
        Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(org.name, style: CustomTextStyle.h1)),
        _about(org),
      ],
    );
  }

  Widget _bigAvatar(Org org) => Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 7,
          ),
        ),
        child: const CircleAvatar(
          backgroundImage: AssetImage('assets/images/cats_of_uplb.jpg'),
          radius: 50,
          backgroundColor: Colors.white,
        ),
      );

  Widget _about(Org org) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          children: [
            Card(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text("About", style: CustomTextStyle.h2),
                    const SizedBox(height: 20),
                    Center(
                        child: Text(org.about!, style: CustomTextStyle.body)),
                    const SizedBox(height: 20),
                    openForDonations(org)
                  ],
                ),
              ),
            ),
            ToggleStatus(org: org),
          ],
        ),
      );

  Row openForDonations(Org org) {
    return Row(
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
    );
  }
}

class ToggleStatus extends StatelessWidget {
  const ToggleStatus({
    super.key,
    required this.org,
  });

  final Org org;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 13,
      right: 20,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
          color: CustomColors.primary,
          shape: BoxShape.circle,
        ),
        child: InkWell(
          onTap: () {
            context.read<CurrentOrgProvider>().toggleOpenForDonations();
          },
          child: Icon(
            org.openForDonations ? Icons.close : Icons.check,
            color: CustomColors.secondary,
          ),
        ),
      ),
    );
  }
}
