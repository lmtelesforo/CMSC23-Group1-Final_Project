import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:provider/provider.dart';
import '../../providers/textfield_providers.dart';
import '../donation_page/donor_page.dart';
import 'package:intl/intl.dart';

class DateTimePicker extends StatefulWidget {
  const DateTimePicker({super.key});

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  late String? dateandtime = '';

  showDatePicker() async {
    DateTime? dateTime = await showOmniDateTimePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate:
          DateTime(1600).subtract(const Duration(days: 3652)),
      lastDate: DateTime.now().add(
        const Duration(days: 3652),
      ),
      is24HourMode: false,
      isShowSeconds: false,
      minutesInterval: 1,
      secondsInterval: 1,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      constraints: const BoxConstraints(
        maxWidth: 350,
        maxHeight: 650,
      ),
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1.drive(
            Tween(
              begin: 0,
              end: 1,
            ),
          ),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: true,
      selectableDayPredicate: (dateTime) {
        // Disable 25th Feb 2023
        if (dateTime == DateTime(2023, 2, 25)) {
          return false;
        } else {
          return true;
        }
      },
    );
    if (dateTime != null) {
      print(dateTime);
      dateandtime = dateTime.toString();
      int space = dateandtime!.indexOf(' '); // extract date w/c is before the first space

      String time = DateFormat('hh:mm a').format(dateTime);

      String date = dateandtime!.substring(0, space);
      DateTime selectedDate = DateTime.parse(date);

      DateTime currentDate = DateTime.now();
      DateTime nextDay = currentDate.add(Duration(days: 1));
      
      print(currentDate);
      print(nextDay);

      if (selectedDate.year >= nextDay.year && selectedDate.month >= nextDay.month && selectedDate.day >= nextDay.day) {
        // one day after the current date
        print('Selected date is at least one day after the current date.');
        Provider.of<TextfieldProviders>(context, listen: false).updateDate(date);
        Provider.of<TextfieldProviders>(context, listen: false).updateDateTime(dateTime);
        Provider.of<TextfieldProviders>(context, listen: false).dateandtimepicked(true);
        Provider.of<TextfieldProviders>(context, listen: false).updateTime(time);
      } 
      else {
        // not one day after the current date
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Drop-offs must be made at least one day after making the donation.'),
          ),
        );
      }

      
    } else {
      print('No date and time chosen.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TextfieldProviders>();
    final Size screenSize = MediaQuery.of(context).size;
    
    return Container (
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(252, 190, 79, 1),
              textStyle: TextStyle(
                fontSize: 16,
              ),
              padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.1, vertical: screenSize.height * 0.01), // Adjusted padding
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            onPressed: () {
              showDatePicker();
            }, 
            child: Text(
              'Select Date and Time', 
              style: TextStyle(
                color: const Color.fromRGBO(55, 61, 102, 1),
                fontFamily: "Montserrat",
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ],
      )
    );
  }
}