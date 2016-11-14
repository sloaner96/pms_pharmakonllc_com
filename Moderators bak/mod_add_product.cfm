<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<title>Add Client/Product</title>

<LINK REL="stylesheet" HREF="speakerstyle.css" TYPE="text/css">
<!---Grab an array of all clients assigned to this moderator---->
<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="GetClients">
	SELECT DISTINCT client_code 
	FROM speaker_clients
	WHERE speakerid = #url.speakerid#
</CFQUERY>

<cfif GetClients.recordcount>
	<cfset ClientsArray = ArrayNew(1)>
	
	<cfoutput query="GetClients">
		<cfset ClientsArray[currentRow] = #trim(GetClients.client_code)#>
	</cfoutput>
	
	<cfloop from="1" to="#ArrayLen(ClientsArray)#" index="p" step="1">
		<cfset ClientsArray[p] = "'" & #ClientsArray[p]# & "'">
	</cfloop>
	
	<cfset ListofClients = ArraytoList(ClientsArray, ",")>	
	<cfset ArrayHasData = 1> 
<cfelse>
	<cfset ArrayHasData = 0>
</cfif>
	
<script language="JavaScript">

var checkDuplicates = <cfoutput>#ArrayHasData#</cfoutput>

function CheckFields(oForm)
{
	if(oForm.client_code.value != "") //Check for Client Code
	{
		if(oForm.fee.value != "") //Check for fee
		{
			if(checkDuplicates == 1)  
			{
				var Clients = new Array(<cfoutput>#ListofClients#</cfoutput>); //Set the Javascript Array to the CF List Created above
				var FoundError = false;
				for(var i=0; i<Clients.length; i++) //Loop all clients in the array
				{
					if(oForm.client_code.value == Clients[i]) //Check for a match
					{
						if(oForm.comments.value == "") //If the comments field is empty set FoundError to true and return false below.
						{
							alert("Because this moderator already is assigned to this client\nyou must enter a comment explaining why you are adding a\nsecond fee for the same client.");
							FoundError = true;						
						}
					}
				}
				/***Return true or false outside the loop because we if the first Client[i] doesn't myesh 
				the client_code.value it will return true and exit the function.*****/
				if(FoundError)
				{
					return false;
				}
				else
				{
					return true;
				}
			}
			else
			{
				return true;
			}			
		}
		else
		{
			alert("Please enter a Fee.");
			return false;
		}
	}
	else
	{
		alert("Please select a client code");
		return false;
	}
}
</script>

</head>

<body bgcolor="#FBF9EB">

<!--- fetch all client_codes --->
<CFQUERY DATASOURCE="#application.projdsn#" NAME="qfetch">
	SELECT DISTINCT client_code 
	FROM client_proj 
	ORDER BY client_code
</CFQUERY>	


<cfoutput>
<form name="client_add" action="mod_add_product_action.cfm?speakerid=#url.speakerid#&no_menu='1'"  onSubmit="return CheckFields(this)" method="post">
</cfoutput>
<table border=0 cellpadding="2" cellspacing="0">
<tr>
	<td colspan="3"><b>Speaker ID:&nbsp;&nbsp;</b><cfoutput>#url.speakerid#</cfoutput></td>
</tr>
<tr>
<td width=150>&nbsp;</td>
<td width=5>&nbsp;</td>
<td width=300>&nbsp;</td>
</tr>
<tr>
	<td colspan="3"><strong><font color="#000080">To add a new client and product to this speaker's profile, complete the information below and hit the Add button.</font></strong></td>
</tr>
<tr><td colspan="3">&nbsp;</td></tr>
<tr BGCOLOR="eeeecc">
	<td align=right><b>Select Client:</b></td>
	<td>&nbsp;</td>
	<td><select name="client_code">
		<option value="">(Select)
		<cfoutput query="qfetch">
		<option value="#trim(client_code)#">#client_code#
		</cfoutput>
		</select>
			
		</td>	
	</tr>
	<tr BGCOLOR="eeeecc"><td colspan="3">&nbsp;</td></tr>
	<tr BGCOLOR="eeeecc">
		<td align="right"><strong>Fee:</strong></td>
		<td align="right">$</td>
		<td><input type="text" name="fee" size="20"></td>
	</tr>
	<tr BGCOLOR="eeeecc"><td colspan="3">&nbsp;</td></tr>
	<tr BGCOLOR="eeeecc">
		<td align="right"><strong>Comments:</strong></td>
		<td align="right">&nbsp;</td>
		<td><input type="text" name="comments" size="60"></td>
	</tr>
	<tr><td colspan="3">&nbsp;</td></tr>
	<tr>
		<td width="83" align="center" valign="top"><INPUT TYPE="submit"  NAME="add" VALUE=" Add "></td>
		<td width="83" align="center" valign="top">
<form action="mod_details.cfm?speakerid=#speakerid#">
<cfoutput>
<INPUT TYPE="submit"  NAME="back" VALUE="Close" onclick="self.close()">
</cfoutput>
</form>
</td>
	</tr>
</table>
</form>
</body>
</html>
