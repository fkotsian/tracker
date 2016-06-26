## B = MAT

A "trigger" complement to the [Fogg Behavior Model](behaviormodel.com). 

```
B = MAT

Behavior = Motivation * Ability * Trigger
```

Trigger acts as the final step in this process: 
Think of it as Push Notifications for Good Habits.

## Technical Details

Trigger is a library to send and respond to SMS messages over Twilio. You define sequences of messages and responses, and a time to send them at, and Twilio handles the rest.
All messages to Twilio are sent to the app as a callback and saved in the database.
We send response messages depending on your message and the timeframe it was received (currently 4 hrs is the max).

Objects:
- Message: Contains the message text for a message of that type.
- MessageChain/ResponseChain: A tree structure that classifies responses and sends the appropriate next Message.
- Sequence: Defines a sequence of MessageChains to be sent, and the times to send them at.
- User: Defines a user and his/her phone number.

All runs in the background with Resque/DelayedJob.

Exposes an API to query. API is smart and knows what user is calling, 
- displaying his/her recent messages, or
- responding to a keyword sent by the user.


All interactions are saved in the database.
All states (eg, responding to MessageChain X, active MessageChains), are saved in the database.
- Would be great to have a quick way to check state for active users - users that responded in last [Window] of time.

[Window] is configurable by MessageChain. Default is 4 hours.

## Use Cases

Some of our implementations:

- Gratitude Tracker
- Study Buddy (Did you study today?)
- TellMeSomethingNice.com (Get a random compliment by text every day)
- GoalTracker (a little more powerful - track any actionable goal through your phone)
- Implementation Intentions

## Contact

Frank Kotsianas
PRs welcome - tested please.
