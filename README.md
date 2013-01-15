gcal-hipchat
============

This is a simple ruby script that fetch daily event from a google calendar and post them in a hipchat room, on mondays it process events for all week.

## Environment Vars

gcal-hipchat has quite a few env vars that is uses:
<table>
  <tr><th>ENV</th><th>Content</th></tr>
  <tr><td>HIPCHAT_API_KEY</td><td>Your HipChat developer API key</td></tr>
  <tr><td>GCAL_USERNAME</td><td>Google Calendar username</td></tr>
  <tr><td>GCAL_PASSWORD</td><td>Google Calendar password</td></tr>
  <tr><td>GCAL_APP_NAME</td><td>Google Calendar rpplication name</td></tr>
  <tr><td>HIPCHAT_ROOM_NUMBER</td><td>HipChat room number</td></tr>
  <tr><td>HIPCHAT_BOT_ALIAS</td><td>HipChat Bot alias</td></tr>
  <tr><td>HIPCHAT_MSG_COLOR</td><td>HipChat Bot color</td></tr>
</table>
