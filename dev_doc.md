# Obtaining Source Code
All source code for this application is included within this repository. This includes both the UI, front-end mobile implementation, as well as the server implementation and integration with our Firebase databasey. Developers can obtain all source code simply by cloning and setting up this repository in their development environment. Instructions for setting up this application in a dev environment can be found in the README of this repository.

# Directory Structure Layout
An overview of what the applicaton MeUni is about, its features, as well as instructions on how to build, test, and deploy the application can be found in the **README**. 

Weekly reports of project goals and the progress made by the initial development team can be found within the **reports** directory

The **mobile** directory hosts the implementation for the app UI and view models for obtaining and communicating data from the front-end via the standard model-view-controller approach. The UI layout design, which includes the views and view model for each of our app pages are created via Flutter, is within the _ui_ folder of this directory. The _api_ folder contains the API implementation for getting and posting data via dart html requests. The _repository_ folder contains the client-side implementation of using the _api_ services to get and post data corresponding to each of our application's features. Custom object types and datastructures are design and hosted within the _models_ folder, with the root structure of the application stored in the _app_ folder.

The **server** directory is comprised of 2 main folders: _test_ is where all the tests for the Controllers reside and _bin_ is where the rest of the files reside. The `server.dart` file in the _bin_ folder is the entry point of the application and is where the actual server as well as all the required components are set up. This is also the file that links all the Controllers together. The _models_ folder contains data models which correspond to the data objects the API deals with such as the event model when creating or getting events via the API. Finally, the _controllers_ folder contain Controllers, which contain logic for handling different endpoints. Each controller is associated with a particular functionality as well as a initial endpoint, such as the EventsController being associated with handling any event calls and is associate with the `'/event'` endpoint. Inside the EventController, it further builds upon the base URi to handle all the different methods it needs to such as `'/events/get'` and `''/events/create`.

# Test the Software
To make use of the flutter tests defined, we can test the front-end mobile application by running the _flutter test_ command within the _mobile_ directory of the repository. Similarly, to the test the server implementation, _flutter test_ can be run within the server directory of the repository.

For visual and demo usage testing of the front-end, the application can be run via running the command `flutter run` within the _mobile_ directory of the repository. Once the application has launched on the device of choosing as chosen during setup, the application can be used for manual testing.

For manual testing of the server, `dart run server.dart` within the _api/bin_ directory. This will launch the server and log `Server listening on port XXXX` in the terminal if succesful. Then, `flutter run` can be run in the _mobile_ directory to launch the application. Testing Operations and interactions can then be performed on the application and the corresponding server requests being made can be retrieved. Manual server operations via curl requests such as `curl http://localhost:8080/events/get` (for getting the events - equivalent to clicking on the Get Events button on the application UI) can also be made for testing.

# Adding new Tests
Testing code for the front-end mobile and server implementations can be found within the test folder of the _mobile_ and _api_ directories respectively. 

For mobile testing, logic of viewmodels can be added within the _viewmodels_ folder. Each viewmodel has a seperate class and file that hosts its respective testing logic, and integration of different combinations of viewmodels are to be hosted within a seperate class and file as well. Testing of the mobile implementation and usage of the api can be added within the _services_ folder, with testing of the API in a seperate class (`api_service_test`) and client usage of the api by each model type in seperate classes as well. Other testing logic for _helper_ logic can be included within the _helper_ folder and structured as necesary and with as much modularity as possible. Any mock data to be used for testing can be hosted within the `mobile/repository/mock` folder.

Similarly, for service testing, testing logic is hosted in the `api/test/controller` folder with seperate classes for each model type. As of now, there is testing logic for the event and user models implemented in event_controller_test.dart and user_controller_test.dart where tests include evaluating the behavior of the server as well. The mock classes to be used for api testing for each of the models can be added to the `api/bin/controllers` folder.


# Building a Release of the Software
The developer must edit the `.env.template` file in the api directory to fill in the indicated variables with their personal values to store the firebase credentials for access to the databse. The developer must then convert this file to a .env after modifying it as needed.

Our CI/CD pipeline will build an apk file upon every push/build to the main branch. The developer can download the generated application apk based on the last version of the application pushed on their device and launch the application for usage.

