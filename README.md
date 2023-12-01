# MeUni

**Beta Milestone version name id: v0.1**

MeUni is a mobile-based application where customers will meet new friends based on their hobbies and interests. Users can also meet based on similar school schedules or interest in school events/organization, and form study groups. Our target customers are university students who have a hard time looking for friends to do particular hobbies or activities with, or studying with others in the same classes. The goal of our product is to help them get connected with other previously-unknown fellow students who would participate in the activities. For example, let’s say a student wants to play a golf game with someone, but he or she doesn’t know anyone who would be interested in playing golf. Then he or she can make a post saying that he or she is looking for someone to play a golf game with. Given that this product is geared towards college students, it will incorporate some aspects of their academics. Users may input their class schedules to connect to other users with similar schedules, or even find other students in the same class. This way students may form study groups and organize meetings through MeUni.

Our goal is to provide the following features. Currently operational features will be identified with an operational tag.
- Posting events: To announce and invite people over to the events (**operational**)
- Viewing events created by other users (**operational**)
- Saving events:
   - A List: Customers can create a list of possible events he/she would attend.
- User profiles: Our app will require 1-2 profile pictures, name, or age. 
- University account verification: This app is for college students only, and thus the verification process, just like the one UW currently has, is essential. (**partially operational**)
     - currently, user validation is implemented via a passcode that they are asked to input. We then validate that the given password matches the one provided upon sign-up
- Schedule Inputter: our users will be able to input in their schedules on our app, possibly in 30-minutes intervals
- Message Board for UW Organizations to advertise events, with RSVP functionality
- Searching for users with filters. Possible filters include
  - Year (freshman, sophomore, etc.)
  - Major/Minor(s)
  - Similar Classes
  - Pronouns
  - Interests
  - Registered Classes 
- Chat/Messaging feature where users can invite users/friends (they would find users using the search query feature detailed above)

That said, we hope to implement the following features if time permits:
- Ability to blocking certain users from having communication or access to one’s profiles
- Implementing a “Share my Location” feature via usage of location sharing APIs.
- Implementation of Payment for Event Ticket Purchases within Application

The repo is setup as such:
- top level weekly report directory has our progress, updates, and issues for eah week as we are developing the application
- the api directory contains logic regarding our database and server setup
- the mobile directory contains logic for our views and view model, where we capture information given by the user to route to the backend and present server communicated details through the UI accordingly

How to Build, Test, and Run this System Application (Instructions are for Setup with Android Studio and IDE Emulator)
- Install Flutter SDK compatible to your OS system (https://docs.flutter.dev/get-started/install). Follow all steps in documentation for complete setup.
- Install Dart SDK compatible to your OS system (https://docs.flutter.dev/get-started/install). Follow all steps in documentation for complete setup.
- Clone this repo and run `flutter pub get` the `MeUni/mobile` and `MeUni/api` directories
- Request for the `.env`, `meuni.jks`, and `key.properties` file by emailing meunihelp@gmail.com with the subject header `Resource Files Request` and body detailing your name, organization, and reason for requesting files and working on application development. Alternatively, there templates for the `.env` and `key.properties` files are in the repository which can be customly defined as well. The `meuni.jks` file must be requested for, however. The `.env` file should be located in the `api` folder and the `meuni.jks`, and `key.properties` file should be located in the `mobile/android` folder.
- Set Flutter SDK Path and Dart SDK Path in IDE Language Settings
- Create a configuration that points to `MeUni/mobile/lib/main.dart` to run application
- Create an emulator to run application on. We recommend Pixel 2 API 29
- Run the mobile application (which can be done via the play button), or via the command `flutter run` within the `MeUni/mobile` directory
- Run the server application via the command `dart run server.dart` within the `MeUni/api/bin` directory
- Application testing can be done via the command `flutter test` which is to be run either within the `MeUni/mobile` and/or `MeUni/api` directories to run the corresponding mobile or api tests
