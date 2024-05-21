import 'package:cmsc23_project/org-view/base_elements/base_screen.dart';
import 'package:cmsc23_project/org-view/base_elements/org_view_styles.dart';
import 'package:flutter/material.dart';

class AddADrive extends StatelessWidget {
  const AddADrive({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Card(
              child: Container(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Column(
                  children: [_uploadImage, _enterName],
                ),
              ),
            ),
          ),
          Container(
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
                Navigator.pop(context);
              },
              child: Text('Submit',
                  style: CustomTextStyle.body
                      .apply(color: CustomColors.secondary)),
            ),
          )
        ],
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
        padding: const EdgeInsets.all(10),
        child: TextFormField(
          //initialValue: 'Enter name of drive',
          style: CustomTextStyle.h1,
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Enter name of drive',
            hintStyle: CustomTextStyle.prompt,
          ),
        ),
      );
}
