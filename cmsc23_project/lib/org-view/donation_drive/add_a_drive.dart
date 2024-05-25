import 'package:cmsc23_project/org-view/base_elements/base_screen.dart';
import 'package:cmsc23_project/org-view/base_elements/org_view_styles.dart';
import 'package:cmsc23_project/providers/current_org_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddADrive extends StatefulWidget {
  const AddADrive({super.key});

  @override
  State<AddADrive> createState() => _AddADriveState();
}

class _AddADriveState extends State<AddADrive> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: Column(
        children: [
          Fields(formKey, nameController, descController),
          Submit(formKey, nameController, descController),
        ],
      ),
    );
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
              children: [_uploadImage, _enterName, _enterDesc],
            ),
          ),
        ),
      ),
    );
  }

  Widget get _uploadImage => Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: CustomColors.prompt,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(Icons.add_a_photo, color: CustomColors.primary),
      );

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
  const Submit(this.formKey, this._nameController, this._descController,
      {super.key});

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

          context.read<CurrentOrgProvider>().addDrive(
                name: _nameController.text,
                desc: _descController.text,
              );

          Navigator.pop(context);
        },
        child: Text('Submit',
            style: CustomTextStyle.body.apply(color: CustomColors.secondary)),
      ),
    );
  }
}
