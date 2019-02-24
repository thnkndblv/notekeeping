# README
Create an Online "Notekeeping" application as per following requirements:

1. User can create, update and delete Notes. User should be allowed to input any number of characters for a note. Example: User can copy paste some 10,000 charactes for a note.
2. Note can be shared between different users with permission as read/update/owner (owner can perform any operation on note read/update/delete/share).
3. If owner removes any user from a note, the note should not be accessible to users to whom this user have shared the note with.
Example: User U1 shares a note N1 with user U2 and user U2 shares note with user U3.
When user U1 removes user U2 from note N1, then user U3 should also not be able to see the note
Important: Owner who created the note cannot be removed as a owner.
4. User can add tags to note. User can view these tags for a note with count of notes it has. *Do not use any Ruby gem or Free plugins for tagging feature. Custom made tagging feature is recommended*
5. Feel free to add any other feature that you think is good for this app.

- Feel free to assume few requirements on your own if something is not mentioned or covered completely. 
- You may deploy your web application to Heroku or any of your preferred server and send us URL of your web application along with source code in github.
- Estimated time to complete: 12 hours
- Total Evaluation Points: 15

Evaluation Criteria:
Following are the weightages and points that we will refer for evaluating this exercise.
UI: 4, DB design: 3, Creativity: 3, Overall Logic & Code Quality: 5
