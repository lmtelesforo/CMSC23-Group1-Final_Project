import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23_project/models/org_signup.dart';
import 'package:cmsc23_project/org-view/base_elements/base_screen/base_screen.dart';
import 'package:cmsc23_project/org-view/base_elements/org_view_styles.dart';
import 'package:cmsc23_project/providers/current_org_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileEditor extends StatelessWidget {
  const ProfileEditor({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return BaseScreen(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: StreamBuilder<QuerySnapshot>(
            stream: context.read<CurrentOrgProvider>().currentOrg,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('An error occurred');
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              Org org = Org.fromJson(
                  snapshot.data!.docs.first.data() as Map<String, dynamic>);

              return Column(
                children: [
                  _About(formKey, org),
                  _Submit(formKey),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _About extends StatelessWidget {
  const _About(this.formKey, this.org);

  final GlobalKey<State<StatefulWidget>> formKey;
  final Org org;

  @override
  Widget build(BuildContext context) => Card(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text('About', style: CustomTextStyle.h2),
              Form(
                key: formKey,
                child: TextFormField(
                  style: CustomTextStyle.body,
                  minLines: 1,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'What is your org about?',
                    hintStyle: CustomTextStyle.prompt.apply(fontSizeDelta: -5),
                  ),
                  textAlign: TextAlign.center,
                  initialValue: org.about,
                  onSaved: (value) {
                    context.read<CurrentOrgProvider>().updateAbout(value!);
                  },
                ),
              ),
            ],
          ),
        ),
      );
}

class _Submit extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const _Submit(this.formKey);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
          }
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(320, 40),
          foregroundColor: CustomColors.secondary,
          textStyle: const TextStyle(
            fontSize: 14,
            fontFamily: 'Poppins-Bold',
          ),
          backgroundColor: CustomColors.primary,
        ),
        child: const Text('Submit'),
      );
}
