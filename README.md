# PushtoTeamsChannel
Create a webhook in a teams channel. 
Link how to: https://docs.microsoft.com/en-us/microsoftteams/platform/webhooks-and-connectors/how-to/add-incoming-webhook
Download the script and adjust the channels names as you see fit. You can add or remove channels. 
After downloading and adjusting the script import it using Import-Module PushtoTeamsChannel.ps1  #You need to insert full path. 
Send a message to a teams channel by Push-Message -Channel "TestChannel1" -Title "Example" -Message "This is a test."
