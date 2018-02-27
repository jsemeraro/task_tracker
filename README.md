# TaskTracker
Part 1:
You're greeted with a Log In page where you can log in or find a Register link.
I chose this design because of ease for the user in orer to sign in. If you are
already logged in, you are greeted with a "Your Tasks" page to display quick 
cards of all tasks to show a user what they are assigned in a clear manner. 
There is a navigation bar that shows Users, Tasks, and whether or not you are 
logged in. Users and Tasks links makes it easy to see all Users and Tasks in
one location. I made the decision to not include a Show feature for a User or
Task simply because of the way the application is working currently, it did not
seem like a necessary feature.

Part 2:
I cleaned up parts of the UI to create a clearer User Experience. The major
changes are: 
  Took out the Edit and Delete buttons from the display tables for the User and
    Tasks due to the information not assisting the user in seeing the necessary
    components for either table. I moved Edit into a User profile (show) page 
    because not everyone looking at a table wants to edit all users but a user 
    looking at a specific user, might want to edit that user. I moved the 
    Delete button into the Edit page because I consider deleting a user an 
    edit. This same logic applies to the Tasks
  If you're not logged into the application, you do not get to see any links in
    the navbar, that is a privelege reserved for people signed in.

Managers:
I implemented managers in it's own table for clarity instead of adding 
convoluted fields to the user table. In order to Manage another user, you have
to go to the User's specific profile page and click the "Manage" button which 
will update the User's page to display you as their Manager. I chose this 
design because it allows for the manager to clearly know who they are managing
instead of being able to randomly click manage for a bunch of users. You cannot
Manage a User that is yourself, your manger, or already managed since all of 
those logically do not make sense in the real world. 

User now has a profile that can be located by clicking their name in the Users
grid: contains their name, email, and if they have a Manager or Underlings,
then they are displayed. If they don't have a manager or underlings, those
categories do not exist since it's unnecessary empty space.

If you're a Manager, you will see three links in the navbar: Users, Team Tasks,
and New Task. Users is the same as before, Team Tasks contains a table of tasks
you have assigned to the users you manage, and New Task just leads to a form to
create a new task for a user under you. I chose for the Manager to have a 
different navbar because it gives the manager the tools they need quickly and
in a manner where it is easy to find.

Team Tasks is in a separate page since it is a concise version of tasks related
to the manager and their workers. There is a button that can be found next to
"Team Tasks" that leads to all tasks if the Manager is interested in seeing all
Tasks in the system.

A major design change from the last version of this project was to allow for
only a manager to create Tasks. The logic for this was that a manager would be
the one telling their workers what to complete and who to complete what, so it
would make sense for the manager to have the ability to create and assign users
to tasks. Creating a new task forces a manager to choose from the workers
beneath them.

Time Spent:
