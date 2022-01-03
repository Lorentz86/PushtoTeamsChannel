<#
  .SYNOPSIS
  Send a message to a teams channel using a webhook. 

  .DESCRIPTION
  You can import this script using Import-module [path of script].ps1. 
  Link how to make a webhook in a teams chanel: 
  https://docs.microsoft.com/en-us/microsoftteams/platform/webhooks-and-connectors/how-to/add-incoming-webhook 
  Paste the link in the [Process] part of the script. 

  .PARAMETER Channel
  Specifies the channel where the message should be in. 

  .PARAMETER Title
   Specifies the Title of the message

   .PARAMETER Message
   Specifies the content of the message

  .INPUTS
  None. You cannot pipe objects to PushtoTeamschannel.ps1.

  .OUTPUTS
  If you run this script in ISE you will reciece a "1" if the message has been delivered. 

  .EXAMPLE
  PS> Push-Message -Channel "Update" -Title "Example" -Message "This is an example"  

  .EXAMPLE
  PS> Push-Message -Channel "Security" -Title "Example" -Message "This is an example of a security warning"  

#>

function Push-Message 
{
[cmdletbinding()]
	param 
	(
		[Parameter(Mandatory=$true)]  
		[ValidateSet("Update","Error","Security")] # Adjust Channel names that you use. I have set up 3 channels, so add or remove if needed. 
		[string]
		$Channel,

		[Parameter(Mandatory=$true)]  #Title parameter
		[string]
		$Titel,

		[Parameter(Mandatory=$true)]  #Message parameter
		[string]
		$Message
	)


	Begin # If you renamed channels at ValidateSet. Rename the Variables and it's content. Go to [Process] to adjust the names of the variables. 
	{
		$Update = 'Update'
		$Error = 'Error'
		$Security = 'Security'
										#BodyTemplate contains the payload of the message.  
		$BodyTemplate = @"
{
   "type":"message",
   "attachments":[
      {
         "contentType":"application/vnd.microsoft.card.adaptive",
         "contentUrl":null,
         "content":{
    "$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
    "type": "AdaptiveCard",
    "version": "1.0",
    "body": [
        {
            "type": "TextBlock",
            "id": "c9abc946-1ac0-f9da-b26b-de3fe67d2650",
            "text": "Title",
            "wrap": true,
            "weight": "Bolder"
        },
        {
            "type": "TextBlock",
            "id": "8e95dbbb-fc68-61fa-4d54-00c9bf380380",
            "text": "Message",
            "wrap": true
        }
    ],
    "padding": "None"
}
      }
   ]
}

"@
	}



	Process # Replace the link of the webhooks of your channel webhook(s). If you made changes to channels at [param] also make adjustments here.
	{
		if ($Update,$Error,$Security -notcontains $Channel)
		{
			Write-host "Please input a channel The following have been configuered: $Update, $Error or $Security"
		}
		elseif ($Channel -eq $Update)
		{
			$webhook = "https://yourdomain.webhook.office.com"
		}
		elseif ($Channel -eq $Error) 
		{
			$webhook = "https://yourdomain.webhook.office.com"
		}
		elseif ($Channel -eq $Security) 
		{
			$webhook = "https://yourdomain.webhook.office.com"
		}
		$body = $BodyTemplate.Replace("Title",$Title).Replace("Message",$Message) # This command will send a message to the webhook.

	}

	End
	{
		Invoke-RestMethod -uri $webhook -Method Post -body $Body -ContentType 'application/json'

	}
}