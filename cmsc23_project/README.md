### CMSC 23 - U4L | Group 1 

Group members:
Winna Cabale
Zach Dwayne Glindro
Laira Claire Telesforo

ElbiDrive Documentation
Welcome to the documentation for ElbiDrive! This guide will help you get started and navigate through the various features of the app.

Table of Contents
Program Description
Getting Started
Prerequisites
Installation
User Authentication
Navigating the App
Troubleshooting

## Program Description
ElbiDrive is a mobile donation application that allows users to donate to organizations, and organizations to accept donations from said users. It uses Firebase for storage (Firebase Storage for pictures; Firebase Cloud Firestore for collections) and authentication (Firebase authentication). 

It allows both users and organizations to create an account and donate to an organization with created donation drives. Users have the option to send photos of their donation to the organization, as well as choose between ‘drop-off’ and ‘pickup’ options for shipping. Users can generate a QR code if they choose to drop-off the donation. They may also cancel any pending donation if they wish.

Organizations then receive the donation on their side with the option to place said donation to a donation drive of their choice. They have the authority to update the statuses of the donations based on whether they have received said donations or not (amongst other things). Organizations may scan the QR code of the user to update the status of the donation.  

Finally, the administrator has access to all the lists of the donations, the organizations, the donors, as well as the power to approve the sign ups of certain organizations (provided they have met certain requirements in the proofs they submitted). 

## Getting Started
### Prerequisites
[Flutter](https://docs.flutter.dev/get-started/install) is required to build the app from source.
### Installation
Clone this repo
```sh
git clone https://github.com/lmtelesforo/CMSC23-Group1-Final_Project
cd CMSC23-Group1-Final_Project/cmsc23_project/
```
[Connect to Firebase](https://firebase.google.com/docs/flutter/setup?platform=android)
Example:
```sh
firebase login
dart pub global activate flutterfire_cli
flutterfire configure
```
Create the apk, or run the app using flutter.
```sh
flutter build apk
or
flutter run --release
```
The apk can be found in /build/app/outputs/apk/release/app-release.apk
Transfer and install the apk onto your device.

### User Authentication
ElbiDrive supports user authentication to ensure security and personalized user experience. Here’s how it works:
Log In: Enter your registered email or username and password to log in to your account.
Sign Up as Donor: Don't have an account yet? New donor users can create an account by providing their name, username, email, password, and additional required information.
Sign Up as Organization: Don't have an account yet? New organization users can create an account by providing their name, username, email, password, and additional required information.
Sign In with Google: Want to use your google account? Sign in with Google and provide the necessary information to start your account.
Log In as Admin: Only administrators of the app are allowed to access this screen. This navigates them to the admin dashboard where they can approve or disapprove users, view all donors, view all donations,  and view all organizations.

###Navigating the App
ElbiDrive is designed with user-friendly navigation to make it easy for users to access various features. Here’s an overview:
For Donor User:
Main Screen: Upon logging in, you will be on the main screen or homepage. This screen provides a list of organizations and their information to help you know more about them. Only organizations that are open for donation will be on the list.
Navigation Drawer: Access additional screens and features such as the profile and view all donations.
Profile: This will show your information such as your name, email, contact number, and address/es.
View All Donation: Enables you to view the donation you made to a certain organization. Tapping the view details will show the donation details you made to the organization you chose to donate. If the status is ‘Pending,’ users can still cancel the donation but if not the user can’t cancel it anymore.
Organization: The user can tap on the organization to see more details about them such as what their organization is about and the ongoing donation drive.
Donation Drive: The user can tap on the list of donation drives to see more details about the donation drive. Only donation drives that are ongoing will be on the list.
Send Donation: If the user decided to donate to that particular organization, they can tap on the send donation button to navigate the donation details where they could fill up the form. 
Donation Details: Form that the user can fill up to donate to the organization. Fill up all necessary details such as what type of donation, if they are for pick up or drop-off, weight of the item, images (optional), date and time of donation, and additional required information.
Send Donation: It will be delivered to the organization and they will continue to update you regarding your donation until they are completed.
For Organization User:
Main Screen: The main page of the app. Want to check your drives? Either navigate to the “Organize your donation drives” section, or tap on one of your favorite drives. You can also check the donations made to your organization in the donation list at the bottom of the screen.
Donation Drives: View your donation drives here. Tap a donation drive to see its details and the donations you’ve linked to it. You can also create drives here by tapping “Add a Drive.” 
Individual Donations: The homepage, as well as every donation drive, has a donation list at the bottom of the screen. Tap on a specific donation to view its details, or edit its status and associated drive. You can only add or set a donation to a drive if the donation is marked as complete.
Drop-off Donations: To update the status of a donation for drop-off, you’ll first have to scan the QR code generated by the donor.
Profile: This page lets you view your organization’s info in the app. The action button on the top right of the card will let you toggle your organization’s status, while the floating edit button on the bottom right will let you edit your organization info.

### Troubleshooting
Encountering issues or have questions? Here are some common troubleshooting steps:
Check Internet Connection: Ensure you have a stable internet connection since some features of the app require it.
Restart the App: Close and reopen the app to see if the issue is resolved, be patient with the app.
Clear Cache: If experiencing performance issues, try clearing the app’s cache in the device setting.
