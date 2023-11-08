# Team Report (11/8)

## Previous Week's Goals
- begin implementation of both the mobile and api projects concurrently
- Migrate/Implement UI from Figma to Flutter
- Set up the Firebase
- Work on Presentation Slides, Reflection, and Demo for Beta Release

## Progress and Issues

### Progress
- Built events and user profile controllers
- Created barebones login screen, event creation form, event list page
- Created a MVP for our application that has the functionality of 1 use case (creating events)
- Created Demo presentation
 
### Issues
- One man down
- Fei go rogue/AWOL
- Newly designed UI has no events showing up on the menu and more functionalities are missed 

## Plans and Goals
- Add Google Authentication for our application
- Create Firebase and link it with the API
- Implement RSVP feature signing up for events

## Meeting Agenda
In case we have extra time after demoing...
1. Summarize on our efforts for the past week
2. Walk through current implementation for Beta Release and user cases implemented
3. Walk through UI design and requirements
4. Discuss new proposal for user validation technique
5. Team Collaboration Overview

# Individual Contributions

## Sandeep Singh

### Previous Week's Goals
- Set up demo flutter app to go along with the demo api
- Structure both the api and flutter app to follow the stying we outlined in the project document
- Get a basic MVP flutter app working by the next milestone with my group members

### Progress and Issues
- Helped with setting up the initial API and aided api team with the implementation
- Set up the events view with functionality to get events
- Made a simplified add event page that only adds an event by its name
- Added functionality for simple login page

### Plans and Goals
- Set up Google Authentication
- Setup firebase for 1 endpoint so API team has a basis to go off on

## Thevina

### Previous Week's Goals
- review and provide feedback for premilimary front end UI design
- have preliminary back-end server implementation complete
- begin on implementing user authentication based on agreed method
- hook up hard-coded UI to server

### Progress and Issues
- worked on beta release demo slides (motivation, proposal, process, timeline, architecture, design sections)
- Worked on Backend Mobile implementation of demo case:
  - event card development
  - login page, validation, and security
  - create event desc, location input and handling
  - date and time picker for event creation
  - overal app aeesthetic/UI, background, widgets, etc.
- write readme with operational features, description of repo setup, how to build, test, and run the system aand information on beta release

### Plans and Goals
- continue work on implementing UI design for create events page
- implement logic for user profile creation, to receive username, individual details, and profile photo
- implement logic for users being able to save events (like a favorites feature)
- begin implementation of search filter


## Apolo

### Previous Week's Goals
- Complete integration of Firebase server to local project
- Start building database
- Assist to build primative frontent to prepare for the beta release
- Assist in organizing a demo prestation and choosing an appropriate use case

### Progress and Issues
- Created Event class, API controller, mock events for demo
- Assited to create User class and its API controller
- Assited with date formatting in event display page

### Plans and Goals
- Begin building datebase in Firebase
- Port API from local server to datebase
- Begin implementing controllers for all other API endpoints

## Fei
### Previous Week's Goals
- deployed the beta version of the app and made sure some key functions were working properly with as less bugs as possible.

### Progress and Issues
- Implemented the slash screen
- Implemented UI for Login view
- Implemented UI for Home-Events view
    
### Plans and Goals
- Finish implementing UI for Uni-in (small group hangout)
- Finish implementing UI for 'Saved' page,
- Finish implementing UI for 'Going' page,
- Discuss with the team to determine what kind of information should be shown/needs to be displayed on the 'Profile' page.(User-view and other people's -view) 
- Start implementing UI for 'Profile' page. (User-view and other people's view) 
- Discuss what should sign-up and/or login going to be like
- Start implementing UI for Sign-up, and maybe optimizing login
- Start implementing UI for chat function, friendlist, and conversation UI.

## Jintae

### Previous Week's Goals
- Actualize the database design conceived to code for the beta milestone.
- Assist in preparing the presentation for the demo day.

### Progress and Issues
- Created a slide that explains the testing packages and tools our team employs.
- Checked if the command "dart run" successfully built the server.
- The command "flutter doctor" didn't work out. So, per error messages, I re-downloaded the Android SDK and installed Visual Studio.
- Designed mock classes that contain user and event data to test the beta version of the app.
### Plans and Goals
- Write code for the backend and the API side to successfully deploy an app that includes the must-have features.
