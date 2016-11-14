<!---------
mod_spkr_AddtoProject.cfm

Allows user to add speaker / moderator to project.

11/27/02 -- Matt Eaves -- Initial Code
rws101505 - added new header, cleaned up HTML
------------------>


<html>
<head>
<LINK REL=stylesheet HREF="piw1style.css" TYPE="text/css">
<title>Project Management System || Add Mod/Speaker to Project</title>
<script language="JavaScript">
function CheckFields(oForm)
{
	if(oForm.SpkrModID.value != "null")
	{
		if(oForm.fee.value != "")
		{
			if(!isNaN(oForm.fee.value))
			{
				return true;
			}
			else
			{
				alert("The fee must be numeric.")
				return false;
			}
		}
		else
		{
			alert("You must enter a fee.")
			return false;
		}
	}
	else
	{
		alert("You must select a Speaker or Moderator.")
		return false;
	}
}
</script>

<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="getNonClient">
	SELECT DISTINCT speakerid
	FROM speaker_clients
	WHERE client_code = '#URL.clientID#' 
	AND type = '#URL.type#'
</cfquery>

<cfif getNonClient.recordcount>
	<cfset SpeakersModIDs = ArrayNew(1)>
	<cfoutput query="getNonClient">
		<cfset SpeakersModIDs[currentRow] = #getNonClient.speakerid#>
	</cfoutput>
	<cfset IDList = #ArrayToList(SpeakersModIDs,",")#>
<cfelse>
	<cfset IDList = 0>
</cfif>

<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="getSpeakerModName">
	SELECT speakerid, lastname, firstname
	FROM Speaker 
	WHERE active = 'yes' 
	AND type = '#URL.type#'
	AND speakerid NOT IN (#IDList#) 
	ORDER BY lastname
</cfquery>

</head>
<body>
<form action="mod_spkr_AddtoProject2.cfm?no_menu=1" method="post" onsubmit="return CheckFields(this)">		
	<TABLE ALIGN="Center" BORDER="0" WIDTH="450px" CELLSPACING="0" CELLPADDING="0" style="border: solid 1px navy;">
		<TR>
			<TD ALIGN="Center" class="tdheader" style="border-bottom: solid 1px navy; padding-top: 2px; padding-bottom: 2px;"><strong>Add <cfif #URL.type# EQ "MOD">Moderator<cfelse>Speaker</cfif> to Client <cfoutput>#URL.clientID#</cfoutput></strong></TD>
		</TR>
		<TR>
			<TD ALIGN="Center" style="padding-top: 8px; padding-bottom: 8px;">
			<font color="##990000"><strong>Select <cfif #URL.type# EQ 'MOD'>Moderator<cfelse>Speaker</cfif></strong></font>&nbsp;&nbsp;
			<select name="SpkrModID">
					<cfif getSpeakerModName.recordcount>
						<cfoutput query="getSpeakerModName">
							<option value="#getSpeakerModName.speakerid#">#trim(getSpeakerModName.lastname)#, #trim(getSpeakerModName.firstname)#</option>
						</cfoutput>
					<cfelse>
						<option value="null">No Spkr/Mod to Add</option>
					</cfif>
			</select>
			</td>
		</tr>
		<tr>
			<td align="center" style="padding-top: 8px; padding-bottom: 8px;">
				<font color="##990000"><strong>Fee</strong></font>&nbsp;&nbsp; $<input type="text" name="fee" size="10">
			</td>
		</tr>
		<tr>
			<td align="center" style="padding-top: 8px; padding-bottom: 8px;"><font color="##990000"><strong>Comments</strong></font>&nbsp;&nbsp; <input type="text" name="comments" size="45"></td>
		</tr>
		<TR>
			<TD ALIGN="Center" style="padding-top: 4px; padding-bottom: 4px;"><input type="submit"  value=" Add to Client "></TD>
		</TR>
	</table>
	<cfoutput>
		<input type="hidden" name="clientCode" value="#URL.clientID#">
		<input type="hidden" name="smType" value="#URL.type#">
	</cfoutput>
</form>

</body>
</html>
