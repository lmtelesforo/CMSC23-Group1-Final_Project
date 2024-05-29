import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23_project/models/donation_drive.dart';
import 'package:cmsc23_project/org-view/base_elements/base_screen/base_screen.dart';
import 'package:cmsc23_project/org-view/base_elements/org_view_styles.dart';
import 'package:cmsc23_project/providers/current_org_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DriveForm extends StatefulWidget {
  const DriveForm({super.key});

  @override
  State<DriveForm> createState() => _DriveFormState();
}

class _DriveFormState extends State<DriveForm> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String? id = ModalRoute.of(context)!.settings.arguments as String?;

    if (id != null) {
      return StreamBuilder<DocumentSnapshot>(
          stream: context.read<CurrentOrgProvider>().drive(id),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('An error occurred');
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            DonationDrive? drive = snapshot.data!.data() == null
                ? null
                : DonationDrive.fromJson(
                    snapshot.data!.data()! as Map<String, dynamic>);

            nameController.text = drive?.name ?? '';
            descController.text = drive?.description ?? '';

            return BaseScreen(
              body: Column(
                children: [
                  Fields(formKey, nameController, descController),
                  Submit(formKey, nameController, descController, id: id),
                ],
              ),
            );
          });
    } else {
      return BaseScreen(
        body: Column(
          children: [
            Fields(formKey, nameController, descController),
            Submit(formKey, nameController, descController),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    super.dispose();
  }
}

class Fields extends StatelessWidget {
  final GlobalKey<FormState> _formKey;
  final TextEditingController _nameController;
  final TextEditingController _descController;

  const Fields(this._formKey, this._nameController, this._descController,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [_enterName, _enterDesc],
            ),
          ),
        ),
      ),
    );
  }

  Widget get _enterName => Container(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: TextFormField(
          controller: _nameController,
          style: CustomTextStyle.h1,
          textAlign: TextAlign.center,
          minLines: 1,
          maxLines: null,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Enter name of drive',
            hintStyle: CustomTextStyle.prompt,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a name';
            }
            return null;
          },
          onSaved: (value) {
            _nameController.text = value!;
          },
        ),
      );

  Widget get _enterDesc => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextFormField(
          controller: _descController,
          style: CustomTextStyle.body,
          textAlign: TextAlign.center,
          minLines: 1,
          maxLines: null,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Enter description of drive',
            hintStyle: CustomTextStyle.prompt.apply(fontSizeDelta: -5),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a description';
            }
            return null;
          },
          onSaved: (value) {
            _descController.text = value!;
          },
        ),
      );
}

class Submit extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController _nameController;
  final TextEditingController _descController;
  final String? id;

  const Submit(
    this.formKey,
    this._nameController,
    this._descController, {
    this.id,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(320, 40),
          foregroundColor: CustomColors.secondary,
          textStyle: const TextStyle(
            fontSize: 14,
            fontFamily: 'Poppins-Bold',
          ),
          backgroundColor: CustomColors.primary,
        ),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
          }

          if (id == null) {
            context.read<CurrentOrgProvider>().addDrive(
                  _nameController.text,
                  _descController.text,
                );
          } else {
            context.read<CurrentOrgProvider>().editDrive(
                  id!,
                  newName: _nameController.text,
                  description: _descController.text,
                );
          }

          Navigator.pop(context);
        },
        child: Text('Submit',
            style: CustomTextStyle.body.apply(color: CustomColors.secondary)),
      ),
    );
  }
}
