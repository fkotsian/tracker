# Tracker

Track your business through SMS.

## Stories

#Phone number
#Can send custom message
#Can define an autoresponse to a message

#Can receive text of a message

Can send a message with a codeword to a message and get a defined response back
Can respond to a defined respose with a second response
Can record the data from that second response

Response codes (triggers) are not saved with message in DB.

Tasks to summarize the: workouts, calorie logs (daily), diary logs (weekly - "this week you did:...")
Action to interact with certain categories: 'Ask #{category}' -- report latest task for that category

Can define a custom checkin message
Can receive that message when we text the number
 - expose a custom URL and text back to it
 - app is live
Can send a response back to the message and have it logged

Can get the message 1x/day at a defined time
Can read a feed of messages and responses sent back to the service 

Register a phone number for a user
Load numbers and API keys in secretly
Send a dummy message on a day
 - url: /:user/checkin
	/:user/goals/1
Send a defined message on a day
Get responses to that message
User can define a checkin message
User is texted 1ce per day with a checkin message
User can see responses to that checkin message in descending order by day on a dashboard view

User can see analytics or graph of frequent responses (if is a yes/no question)
User can see word cloud of frequent responses (if is a text-based question)

App can register other users to their own phone numbers and store results
User can enter 3 big goals they have
User can enter monthly milestones into app

User can text "Goals" and receive 3 big goals
User can text "Checkin" and receive a checkin message
User can text "Goal1" and receive current value of goal1 (if hooked up)
"" Goal2
"" Goal3

## Progress 
