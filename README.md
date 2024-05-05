# CMSC23-Group1-Final_Project

Elbi Donation System

General Guidelines
- The project is to be done by a group of 3 to 4 people.
- The lab instructor will assign the groups.
- Firebase Cloud Firestore will be used as the database for the project, while Firebase
Authentication will be used for the login/signup functionality.
- Only one Github repository per group.
- Each member must have a minimum of 5 commits for the project.
- Must have documentation and Readme file
- ReadMe should contain the group details, program description, installation guide, and how to use the app.
  
Screens
  - All of these screens/features are required

User’s View
- Sign in (Authentication)
- Sign up (Name, Username, Password, Address/es, Contact No.)
- Can sign up as an organization that accepts donations
- Must enter the following information:
- Name of organization
- Proof/s of legitimacy
- Subject to approval
- Signed up as donors by default

Donors’ View
- Homepage - List of organizations where donors can send their donations
- Donate
- Will open upon selecting an organization
- Enter the following information:
- Donation item category checkbox:
- Food
- Clothes
- Cash
- Necessities
- Others (can add more categories as necessary)
- Select if the items are for pickup or drop-off
- Weight of items to donate in kg/lbs
- Photo of the items to donate (optional input)
- Should be able to use the phone camera
- Date and time for pickup/drop-off
- Address (for pickup) - can save multiple addresses
- Contact no (for pickup)
- If the item is for drop-off, the donor should be able to generate a
  QR code that must be scanned by the organization to update the
  donation status
- A Donation can be canceled
- Profile

Organization’s View
- Homepage - List of donations
- Donation
- Can check the information entered by donors
- Can update the status of each donation
- Pending
- Confirmed
- Scheduled for Pick-up
- Complete
- Canceled
- Donation drives - showcase of all charity/donation drives
- Can CRUD
- Can link donations to donation drives
- Photos must be included as proof of where the donation
  ended up
- Sends auto-sms and notifications to donors so they will
  know where their donation ended up
- Profile
- Organization Name
- About the organization
- Status for donations (open or close)

Admin’s View
- Sign in (Authentication)
- View All Organizations and Donations
- Can approve an organization sign up
- View All Donors

Optional Features for Additional Points
- Can save QR in the device with status and date created.
- Google sign in (auth)
- Points can also be awarded for UI/UX
- Use of firebase storage for storing images instead of converting to base64

Limitation of the App
- The app does not need to handle how donors actually send donations and how organizations actually receive the donations
Milestones
  1. Screens without functionality (3 screens minimum)
  2. Authentication
  3. Firebase CRUD
Deadline
  May 31, 2024 10AM (the code must be in the main branch)
Flutter Packages
You are encouraged to use packages
- QR generator: https://pub.dev/packages/qr_flutter
- QR reader: https://pub.dev/packages/qr_bar_code_scanner_dialog
Images
- To avoid using firebase storage, Images must be converted to Base64 before it can be
  stored in Firebase (see tutorial). But if you’re willing to learn how to use firebase storage
  that would be better.
  Presentation Guidelines
- The mobile app must be installed on your device. (1-donor view, 1-organization view,
  1-admin)
