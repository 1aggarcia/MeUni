# Team Report (11/15)

## Previous Week's Goals
- Add Google Authentication for our application
- Create Firebase and link it with the API
- Implement RSVP feature signing up for events

## Progress and Issues

### Progress
- Added Google Login-in portal to log-in page
- Setup Firebase connection
- Implemented front-end api and refactored with API calls

### Issues
- Google Authentication is not working currently, google login popup is working but when selecting a user to log in as, app crashes

## Plans and Goals
- work to develop study group feature (should be similar to events)
- implement search feature
- enhance UI screen design

## Meeting Agenda
1. Summarize on our efforts for the past week
2. Collect feedback from Beta Release Demo
3. Discuss two major next steps: study group + search filter
4. Discuss Firebase setup
5. Team Collaboration Overview

# Individual Contributions

## Sandeep Singh

### Previous Week's Goals
- Set up Google Authentication
- Setup firebase for 1 endpoint so API team has a basis to go off on


### Progress and Issues
- Didnt' manage to setup firebase as did not realise Firebase was NoSql, API team managed to get reading working though
- Worked on adding DI to the API project so that tests were only dependent on Mock and will not add random events to the actual databse
- Helped API team with refactoring some of the code to work around this
- Implemented Google Authentication but not working as intended

### Plans and Goals
- Fix Google Authentication
- Merge Fei's UI Code from mobile-ui branch to actual mobile branch and link functionality to the new UI

## Thevina

### Previous Week's Goals
- continue work on implementing UI design for create events page
- implement logic for user profile creation, to receive username, individual details, and profile photo
- implement logic for users being able to save events (like a favorites feature)
- begin implementation of search filter

### Progress and Issues
- worked on slides for beta release demo
- implemented api and client side usage of api by event model
- drafted the developer documentation user guide
- performed manual testing of Get and Create event operations via api
- drafted design of search filter
- wrote up team weekly report


### Plans and Goals
- begin code implementing search filter
- develop view model and UI pages for study group feature
- implement client side usage of api by user model


## Apolo

### Previous Week's Goals
- Begin building datebase in Firebase
- Port API from local server to datebase
- Begin implementing controllers for all other API endpoints

### Progress and Issues
- Completed barebones demo version of Events and User APIs
- Sucessful database read from Firebase to APIs
- Convert Event processing from List to Map
- Issues with datatype conversions from JSON to controllers
- Still lacking database write capabilities

### Plans and Goals
- Establish write capability from controllers
- Convert JSON from database to usable maps to return to client
- Complete Event controller with tests
- Move database out of testing mode (authentication will be required to access database)


## Fei
### Previous Week's Goals
- Finish implementing UI for Uni-in (small group hangout)
- Finish implementing UI for 'Saved' page,
- Finish implementing UI for 'Going' page,
- Discuss with the team to determine what kind of information should be shown/needs to be displayed on the 'Profile' page.(User-view and other people's -view) 
- Start implementing UI for 'Profile' page. (User-view and other people's view) 
- Discuss what should sign-up and/or login going to be like
- Start implementing UI for Sign-up, and maybe optimizing login
- Start implementing UI for chat function, friendlist, and conversation UI.

### Progress and Issues
- Finished implementing UI for Uni-in (small group hangout)
- Finished implementing UI for 'Saved' page,
- Finished implementing UI for 'Going' page,
- We decided to only display the photo, name, year, pronouns, Bio, and interest for now. The difference between the user view and the other user view is the user view with the bottom shows "Edit" and when viewing the other user, the bottom shows "Chat"
- we decided for a user to sign up with Gmail, and only allowd .edu domains to sign up/log-in

- The Issue I have is to navigate between "Home", "Saved", and "Going", it does not navigate me to a different page.

### Plans and Goals
- fixed the bottom navigate bar so it can switch between "Home", "Save", "Going", "Profile"
- finish implementing UI for the 'Profile' page. (User-view and other people's view) 
- finish implementing UI for chat function, friendliest, and conversation UI.

## Jintae

### Previous Week's Goals
- Write code for the backend and the API side to successfully deploy an app that includes the must-have features.

### Progress and Issues
- Established the API-database connection in a way that when Postman sends a GET request the API side reads what is inside the database.

### Plans and Goals
- Now that the "read" part works, I have to make the "write" part work. That is, data from the frontend should find its way to the database.
