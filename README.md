# MeUni

**Final Release version name id: v1.0**

MeUni is a mobile-based application where customers will meet new friends based on their hobbies and interests. Users can also meet based on similar school schedules or interest in school events/organization, and form study groups. Our target customers are university students who have a hard time looking for friends to do particular hobbies or activities with, or studying with others in the same classes. The goal of our product is to help them get connected with other previously-unknown fellow students who would participate in the activities. For example, let’s say a student wants to play a golf game with someone, but he or she doesn’t know anyone who would be interested in playing golf. Then he or she can make a post saying that he or she is looking for someone to play a golf game with. Given that this product is geared towards college students, it will incorporate some aspects of their academics. Users may input their class schedules to connect to other users with similar schedules, or even find other students in the same class. This way students may form study groups and organize meetings through MeUni.

In the final release, the following features are fully functional:
- Posting events: To announce and invite people over to the events
- Viewing events created by other users
- Saving Events: Users can search through events and join those that interest them
- User profiles: Our app requires name, year, pronouns. 
- University account verification: This app is for college students only, and thus the verification process, just like the one UW currently has, is essential.
- Course Inputter: Our users will be able to input in their courses on the app
  - Initial idea was to incorparate a search based on user courses and utilize them to connect students, but due to time constraints this could not be fully implemented

Here are some other planned features for which we do not have an implementation in this release, but would be essential parts of future releases:
- Message Board for UW Organizations to advertise events, with RSVP functionality
- Searching for users with filters. Possible filters include
  - Year (freshman, sophomore, etc.)
  - Major/Minor(s)
  - Similar Classes
  - Pronouns
  - Interests
  - Registered Classes 
- Chat/Messaging feature where users can invite users/friends (they would find users using the search query feature detailed above)

Additionally, these features were not initially planned as must-have but would be further developed in future releases after all of the above:
- Ability to blocking certain users from having communication or access to one’s profiles
- Implementing a “Share my Location” feature via usage of location sharing APIs.
- Implementation of Payment for Event Ticket Purchases within Application

The repo is setup as such:
- top level weekly report directory has our progress, updates, and issues for eah week as we are developing the application
- the api directory contains logic regarding our database and server setup. This code runs on Google Could Run.
- the mobile directory contains logic for our views and view model, where we capture information given by the user to route to the backend and present server communicated details through the UI accordingly. This code is all included in the user APK.

Final Release APK:
- This APK file is the easiest way to run MeUni, allowing you to directly install the v1.0 version of MeUni to an Android System. MeUni is installable on Android devices by downloading the .apk file "MeUni_Android.apk" in the "Assets" section of the [v1.0 release page](https://github.com/SunnySoldier357/MeUni/releases/tag/v1.0). The system will likely give you warnings saying the file is unsafe upon download, and block the app upon installation, since we are not verified developers in the Google Play Store. You may bypass this warning by tapping "More Details", then "Install Anyway" when opening the .apk file.

How to Build, Test, and Run this System Application (Instructions are for Setup with Android Studio and IDE Emulator)
- Install Flutter SDK compatible to your OS system (https://docs.flutter.dev/get-started/install). Follow all steps in documentation for complete setup.
- Install Dart SDK compatible to your OS system (https://docs.flutter.dev/get-started/install). Follow all steps in documentation for complete setup.
- Clone this repo and run `flutter pub get` the `MeUni/mobile` and `MeUni/api` directories
- Request for the `.env`, `meuni.jks`, and `key.properties` file from the developers with the subject header `Resource Files Request` and body detailing your name, organization, and reason for requesting files and working on application development. Alternatively, there are templates for the `.env` and `key.properties` files in the repository within the location they are to be included which can be customly defined as well. The `meuni.jks` file must be requested for, however. The `.env` file should be located in the `api` folder and the `meuni.jks`, and `key.properties` file should be located in the `mobile/android` folder.
    - Request access by emailing meuni.help@gmail.com, or from one of the team members, Fei Huang (feifeifeih@gmail.com), Apolo Garcia, Thevina Dokka, Jintae Cho, or Sandeep Singh.
- Set Flutter SDK Path and Dart SDK Path in IDE Language Settings
- Create a configuration that points to `MeUni/mobile/lib/main.dart` to run application
- Create an emulator to run application on. We recommend Pixel 2 API 29
- Run the mobile application (which can be done via the play button), or via the command `flutter run` within the `MeUni/mobile` directory
- Run the server application via the command `dart run server.dart` within the `MeUni/api/bin` directory
- Application testing can be done via the command `flutter test` which is to be run either within the `MeUni/mobile` and/or `MeUni/api` directories to run the corresponding mobile or api tests
