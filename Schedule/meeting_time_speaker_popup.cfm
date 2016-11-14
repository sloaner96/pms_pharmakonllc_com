<!---
	*****************************************************************************************
	Name:		meeting_time_speaker_popup.cfm
	Function:	Allows user to add/delete extra speakers.
	History:	Matt Eaves -- Initial Code -- 12/10/02

	*****************************************************************************************
--->

<CFSET year = #URL.year#>
<CFSET month = #URL.month#>
<CFSET day = #URL.day#>
<CFSET Row_ID = #URL.uniqueID#>
<CFSET meeting_code = #URL.meeting_code#>
<CFSET ModeratorID = #URL.modID#>
<CFSET ModeratorRowID = #URL.modRowID#>
<CFSET SpeakerID = #URL.spkrID#>
<CFSET SpeakerRowID = #URL.spkrRowID#>
<CFSET CivTime = #URL.time#>
<CFSET MilitaryBegin = #URL.beginM#>
<CFSET MilitaryEnd = #URL.EndM#>
<!---to avoide confusion between variables and query objects going to set a temp variable here---->
<cfset temp_rowid = #Row_ID#>

<HTML>
<HEAD>
<LINK REL=STYLESHEET HREF="PIW1STYLE.CSS" TYPE="TEXT/CSS">
<style>
SPAN.DeleteButton
{
	color: red;
}
</style>
<TITLE>Add/Delete Speakers</TITLE>
<SCRIPT LANGUAGE="JavaScript">

function GoBack()
{
	<cfoutput>
	url2="meeting_time_add.cfm?no_menu=1&refresh=0&day=#Day#&month=#month#&year=#year#"
	</cfoutput>
	window.open(url2, "_self");
}

function CheckSpkrAdd(oForm)
{
	var selectBox = oForm.SpkrAdditionalAdd;
	if(selectBox.options[selectBox.selectedIndex].value == "NULL")
	{
		alert("Please Select a Speaker");
		return false;
	}
	else
	{
		return true;
	}
}

function ChangeCursor(oTarget)
{
	oTarget.style.cursor = "hand";
	oTarget.style.textDecoration = "underline";
}

function ChangeCursorBack(oTarget)
{
	oTarget.style.cursor = "default";
	oTarget.style.textDecoration = "none";
}

function DeleteAdditionalSpkr(oTarget)
{

	var message = "Are you sure you want to delete this addtional speaker?"

	if(confirm(message))//They want to delete
	{
		if(document.all.DeleteButtonSpkr.length > 1)//Is there more than one delete spkr form on the page?
		{
			for(i=0; i<document.all.DeleteButtonSpkr.length; i++)//Loop through all the Delete Buttons
			{
				/*****If the delete button clicked matches a delete button in the array, submit the form
				correspondig to that place in the array.******/
				if(oTarget == document.all.DeleteButtonSpkr[i])
				{
					DeleteSpkrFrm[i].submit();
				}
			}

		}
		else
		{
			DeleteSpkrFrm.submit();
		}
	}
	else
	{
		//do nothing;
	}


}

</script>
</HEAD>


<cfscript>
	//Create Object
	Available = createObject("component","pms.com.cfc_check_available");
</cfscript>
<cfset SpeakersArray = ArrayNew(1)>

<!--- pull speakers by client and availability --->
<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="GetSpeakers">
	SELECT a.id, a.rowid, st.firstname, st.lastname, st.speaker_id, st.type, sc.client_code, sc.rowid as spkrrow, sc.fee
	FROM availability a, spkr_table st, speaker_clients sc
	WHERE active = 'ACT' AND a.id = sc.owner_id
	AND sc.client_code = '#Left(session.project_code, 5)#'
	AND a.id = st.speaker_id
	AND a.year=#year#
	AND a.month=#month#
	AND a.x#day#=1
	AND st.type='SPKR'
	ORDER BY st.lastname, st.firstname;
</CFQUERY>

<cfif #GetSpeakers.recordcount#>
	<cfloop query="GetSpeakers">
		<cfscript>
			//SpkrAvail = Available.getAllDay(SpkrModCode="#GetSpeakers.speaker_id#",cfcYear="#year#",cfcMonth="#month#",cfcDay="#day#");
			MeetingTime = Available.setMeetingHours(cfcBeginTime="#MilitaryBegin#",cfcEndTime="#MilitaryEnd#");
			SpkrConflict = Available.getConflict(SpkrModCode="#GetSpeakers.speaker_id#",TimeSelected="#MeetingTime#",Year="#year#",Month="#month#",Day="#day#");
		</cfscript>

		<cfif #SpkrConflict# EQ false>
			<cfset temp = #ArrayAppend(SpeakersArray, GetSpeakers.spkrrow)#>
		</cfif>
	</cfloop>
<cfelse>
	<cfset SpeakersArray[1] = "Null">
</cfif>

<cfif SpeakerID NEQ ''>
<!---Get the Speaker for this Meeting--->
<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="GetMeetingSpeaker">
	SELECT firstname, lastname
	FROM spkr_table
	WHERE speaker_id = #SpeakerID#
</CFQUERY>
<!---Get the speaker fee--->
<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="GetSpeakerFee">
	SELECT fee
	FROM speaker_clients
	WHERE rowid = #SpeakerRowID#
</CFQUERY>
</CFIF>

<!---Get the Moderator for this Meeting--->
<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="GetMeetingModerator">
	SELECT firstname, lastname
	FROM spkr_table
	WHERE speaker_id = #ModeratorID#
</CFQUERY>
<!---Get the moderator fee--->
<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="GetModeratorFee">
	SELECT fee
	FROM speaker_clients
	WHERE rowid = #ModeratorRowID#
</CFQUERY>

<BODY BGCOLOR="#FFFFFF" ALIGN="center" style="font-family: arial;">

<CENTER>
<div style="font-size: 14px; font-family: arial; font-weight: bold; padding-bottom: 5px; color: navy;" width="100%">Add Additional Speakers <CFOUTPUT>#session.project_code# - #URL.month#/#URL.day#/#URL.year#</CFOUTPUT></div>
<TABLE BORDER="0" CELLSPACING="0" CELLPADDING="0" width="100%" style="text-align: center;">
	<TR>
		<TD>&nbsp;</TD>
		<TD>&nbsp;</TD>
		<TD>&nbsp;</TD>
	</TR>
	<TR>
		<TD style="padding-bottom: 3px; border-bottom: solid 1px navy;"><B>Meeting Time</B></TD>
		<TD style="padding-bottom: 3px; border-bottom: solid 1px navy;"><B>Moderator</B></TD>
		<TD style="padding-bottom: 3px; border-bottom: solid 1px navy;"><B>Speaker</B></TD>
	</TR>
	<TR>
		<TD style="padding-top: 4px;">
			<cfoutput>#CivTime#</cfoutput>
		</TD>
		<TD style="padding-top: 4px;">
			<cfoutput>#trim(GetMeetingModerator.firstname)# #trim(GetMeetingModerator.lastname)# - #DollarFormat(GetModeratorFee.fee)#</cfoutput>
		</TD>
		<TD style="padding-top: 4px;">
		<cfif SpeakerID EQ "">
			N/A
		<cfelse>
			<cfoutput>#trim(GetMeetingSpeaker.firstname)# #trim(GetMeetingSpeaker.lastname)# - #DollarFormat(GetSpeakerFee.fee)#</cfoutput>
		</cfif>
		</TD>
	</TR>
</TABLE>
</center>
<TABLE BORDER="0" CELLSPACING="0" CELLPADDING="0" width="450px" style="text-align: left; margin-top: 8px;">
	<TR>
		<TD>&nbsp;</TD>
		<TD>&nbsp;</TD>
		<td>&nbsp;</td>
	</TR>
	<TR>
		<TD style="padding-top: 10px;"><strong>Add Additional Speaker(s)</strong></TD>
		<form method="post" action="meeting_time_speaker_action.cfm?no_menu=1" onsubmit="return CheckSpkrAdd(this)">
			<cfoutput>
				<input type="hidden" name="UniqueID" value="#uniqueID#">
				<input type="hidden" name="meeting_code" value="#meeting_code#">
				<input type="hidden" name="txtYear" value="#year#">
				<input type="hidden" name="txtMonth" value="#month#">
				<input type="hidden" name="txtDay" value="#day#">
				<input type="hidden" name="ModerID" value="#ModeratorID#">
				<input type="hidden" name="SpkrID" value="#SpeakerID#">
				<input type="hidden" name="intModRow" value="#ModeratorRowID#">
				<input type="hidden" name="intSpkrRow" value="#SpeakerRowID#">
				<input type="hidden" name="RegTime" value="#CivTime#">
				<input type="hidden" name="MilitaryTimeBegin" value="#MilitaryBegin#">
				<input type="hidden" name="MilitaryTimeEnd" value="#MilitaryEnd#">
			</cfoutput>
			<TD style="padding-top: 10px;">
				<select name="SpkrAdditionalAdd">
				<option value="NULL">(Select a Speaker)</option>
					<cfloop from="1" to="#ArrayLen(SpeakersArray)#" index="p" step="1">
						<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="GetSpkrName">
							SELECT sc.owner_id, sc.fee, st.firstname, st.lastname
							FROM spkr_table st, speaker_clients sc
							WHERE sc.rowid = #SpeakersArray[p]#
							AND sc.owner_id = st.speaker_id
							ORDER BY lastname, firstname;
						</CFQUERY>
						<cfif #SpeakersArray[1]# EQ "Null">
							<option value="Null">No Speakers Available</option>
						<cfelse>
							<cfoutput><option value="#SpeakersArray[p]#">#trim(GetSpkrName.firstname)# #trim(GetSpkrName.lastname)# - #DollarFormat(GetSpkrName.fee)#</option></cfoutput>
						</cfif>
					</cfloop>
				</select>
			</TD>
			<td style="padding-top: 10px;"><input type="submit"  VALUE="  ADD  "></td>
		</form>
	</TR>
</TABLE>
<TABLE BORDER="0" CELLSPACING="0" CELLPADDING="0" width="350px" style="text-align: left;">
	<TR>
		<TD>&nbsp;</TD>
		<TD>&nbsp;</TD>
	</TR>
	<TR>
		<TD colspan="2" style="font-size: 11px; font-family: arial; padding-bottom: 6px; color: navy;"><u><strong>Click Name to Delete</strong></u></TD>
	</TR>
	<TR>
		<TD>&nbsp;</TD>
		<TD>&nbsp;</TD>
	</TR>
	<tr>
		<TD><strong>Current Additional Speaker(s):</strong>&nbsp; &nbsp; &nbsp;</td>
		<TD>
			<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<CFQUERY DATASOURCE="#application.projdsn#" NAME="GetAdditionalSpkrs">
						SELECT staff_id, rowid, client_rowid
						FROM schedule_meeting_time
						WHERE meeting_code = '#meeting_code#' AND staff_type = 5
					</CFQUERY>
					<cfif #GetAdditionalSpkrs.recordcount#>
						<!---to avoide confusion between variables and query objects going to set a temp variable here---->
						<cfloop query="GetAdditionalSpkrs">
							<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="GetSpeakerName">
								SELECT sc.owner_id, sc.fee, st.firstname, st.lastname
								FROM spkr_table st, speaker_clients sc
								WHERE sc.rowid = #client_rowid#
								AND sc.owner_id = st.speaker_id
								ORDER BY lastname, firstname;
							</CFQUERY>
							<cfoutput>
							<form action="meeting_time_speaker_delete.cfm?&no_menu=1" method="post" name="DeleteSpkrFrm">
								<td>
									<input type="hidden" name="deleteID" value="#GetAdditionalSpkrs.staff_id#">
									<input type="hidden" name="UniqueID" value="#temp_rowid#">
									<input type="hidden" name="meeting_code" value="#meeting_code#">
									<input type="hidden" name="txtYear" value="#year#">
									<input type="hidden" name="txtMonth" value="#month#">
									<input type="hidden" name="txtDay" value="#day#">
									<input type="hidden" name="ModerID" value="#ModeratorID#">
									<input type="hidden" name="SpkerID" value="#SpeakerID#">
									<input type="hidden" name="intModRow" value="#ModeratorRowID#">
									<input type="hidden" name="intSpkrRow" value="#SpeakerRowID#">
									<input type="hidden" name="RegTime" value="#CivTime#">
									<input type="hidden" name="MilitaryTimeBegin" value="#MilitaryBegin#">
									<input type="hidden" name="MilitaryTimeEnd" value="#MilitaryEnd#">
									<input type="hidden" name="SpeakerUnique" value="#GetAdditionalSpkrs.rowid#">
									<span id="DeleteButtonSpkr" class="DeleteButton" onmouseover="ChangeCursor(this)" onmouseout="ChangeCursorBack(this)" onclick="DeleteAdditionalSpkr(this)">#trim(GetSpeakerName.firstname)# #trim(GetSpeakerName.lastname)# - #DollarFormat(GetSpeakerName.fee)#</span> &nbsp;
								</td>
							</form>
							</cfoutput>
						</cfloop>
					<cfelse>
						<td>No Additional Speaker(s).</td>
					</cfif>
				</tr>
			</table>
		</TD>
	</tr>
</TABLE>
<br>
<center>
	<INPUT TYPe="button"  VALUE="   Go Back   " NAME="" onclick="GoBack()">
</center>

</BODY>
</HTML>