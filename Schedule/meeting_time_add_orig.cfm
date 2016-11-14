<!--- 
	*****************************************************************************************
	Name:		meeting_time_add.cfm
	Function:	Handles data passed from the child window meeting_time_add_popup.cfm
				and checks to see if a mod or spkr will be available. Then inserts it into 
				the database and refreshes the screen to show what currently is in the 
				databse for that date.
	History:
	
	*****************************************************************************************
--->
<HTML>
<HEAD>
<TITLE>Meetings scheduled for <CFOUTPUT>#URL.month#/#URL.day#/#URL.year#</CFOUTPUT></TITLE>
<LINK REL=STYLESHEET HREF="PIW1STYLE.CSS" TYPE="TEXT/CSS">
<SCRIPT LANGUAGE="JavaScript" src="popup_help.js"></script>
<style>
DIV.DeleteButton
{
	color: red;
}
</style>
<SCRIPT>
function closeandrefresh() 
{
	window.opener.location.href = window.opener.location.href;
	if (window.opener.progressWindow) 
		window.opener.progressWindow.close();
	window.close();
}

function makesure(oTarget)
{
	var message = "Are you sure you want to delete this meeting?"
	
	if(confirm(message))//They want to delete
	{
		if(document.all.DeleteButton.length > 1)//Is there more than one delete form on the page?
		{
			for(i=0; i<document.all.DeleteButton.length; i++)//Loop through all the Delete Buttons
			{
				/*****If the delete button clicked matches a delete button in the array, submit the form 
				correspondig to that place in the array.******/
				if(oTarget == document.all.DeleteButton[i])
				{
					deleteFRM[i].submit();
				}
			}
			
		}
		else
		{
			deleteFRM.submit();
		}
	}
	else
	{
		//do nothing;
	}
}

function EditMeeting(oTarget)
{
	if(document.all.EditButton.length > 1)//Is there more than one edit form on the page?
	{
		for(i=0; i<document.all.EditButton.length; i++)//Loop through all the Edit Buttons
		{
			/*****If the edit button clicked matches a edit button in the array, submit the form 
			correspondig to that place in the array.******/
			if(oTarget == document.all.EditButton[i])
			{
				var temp_modID = EditFRM[i].modID.value;
				var temp_spkrID = EditFRM[i].spkrID.value;
				var temp_uniqueID = EditFRM[i].uniqueID.value;
				var temp_year = EditFRM[i]._year.value;
				var temp_month = EditFRM[i]._month.value;
				var temp_day = EditFRM[i]._day.value;
				var temp_time = EditFRM[i]._time.value;
				var temp_begin = EditFRM[i].M_Begin.value;
				var temp_end = EditFRM[i].M_End.value;
				
				var pointer = "meeting_time_edit_popup.cfm?no_menu=1&year=" + temp_year + "&month=" + temp_month + "&day=" + temp_day + "&time=" + temp_time + "&modID=" + temp_modID + "&spkrID=" + temp_spkrID + "&uniqueID=" + temp_uniqueID + "&beginM=" + temp_begin + "&EndM=" + temp_end;
				window.open(pointer, "_self");
			}
		}
		
	}
	else
	{
		var temp_modID = EditFRM.modID.value;
		var temp_spkrID = EditFRM.spkrID.value;
		var temp_uniqueID = EditFRM.uniqueID.value;
		var temp_year = EditFRM._year.value;
		var temp_month = EditFRM._month.value;
		var temp_day = EditFRM._day.value;
		var temp_time = EditFRM._time.value;
		var temp_begin = EditFRM.M_Begin.value;
		var temp_end = EditFRM.M_End.value;
				
		var pointer = "meeting_time_edit_popup.cfm?no_menu=1&year=" + temp_year + "&month=" + temp_month + "&day=" + temp_day + "&time=" + temp_time + "&modID=" + temp_modID + "&spkrID=" + temp_spkrID + "&uniqueID=" + temp_uniqueID + "&beginM=" + temp_begin + "&EndM=" + temp_end;
		window.open(pointer, "_self");
												
	}
}

function ChangeCursor(oTarget)
{
	oTarget.style.cursor = "pointer";
	oTarget.style.textDecoration = "underline";
}

function ChangeCursorBack(oTarget)
{
	oTarget.style.cursor = "default";
	oTarget.style.textDecoration = "none";
}
</SCRIPT>
</HEAD>
<BODY BGCOLOR="FFFFFF" MARGINHEIGHT="0" MARGINWIDTH="0">

<CFSET year = URL.year>
<CFSET month = URL.month>
<CFSET day = URL.day>	
	
<!--- Saves then refreshes all data inputted from the above form --->
<CFPARAM NAME="url.refresh" DEFAULT="0">

<CFIF "#URL.refresh#" EQ '1'>
	
	<!----Put Component here to convert from Civilian to Military Time. 
	This returns an array.  The [1] position is the begin time and the [2] position is 
	end time.---->
	<cfinvoke 
		component="cfc_time_conversion" 
		method="toMilitary" 
		returnVariable="MilitaryTime" 
		BeginHour="#trim(url.begin_hour)#"
		BeginMinute="#trim(url.begin_minute)#"
		BeginMeridiem="#trim(url.begin_meridiem)#"
		EndHour="#trim(url.end_hour)#"
		EndMinute="#trim(url.end_minute)#"
		EndMeridiem="#trim(url.end_meridiem)#"
	>
	
	
	<!--- pull all line items from schedule_meeting_time for this date --->
	<CFQUERY DATASOURCE="#application.projdsn#" NAME="check">
		SELECT *
		FROM schedule_meeting_time
		WHERE Project_code = '#session.project_code#' 
		AND year = #year# 
		AND month = #month# 
		AND day = #day#
		AND status = 0
	</CFQUERY>
			
<!--- pull the rowid from schedule_meeting_date for this day --->		
	<CFQUERY DATASOURCE="#application.projdsn#" NAME="GetRowid">			
		SELECT DISTINCT rowid, project_code
		FROM schedule_meeting_date
		WHERE year=#URL.year# 
		AND month=#URL.month#
		AND x#URL.day#=1
		AND project_code = '#session.project_code#' 
	</CFQUERY>
	
	<cfscript>
		//Create Object
		Available = createObject("component","cfc_check_available");
		
		//Get Moderator and Speaker Day Availability
		ModAvail = Available.getAllDay(SpkrModCode="#url.mod_id#",cfcYear="#URL.year#",cfcMonth="#URL.month#",cfcDay="#URL.day#");
		SpkrAvail = Available.getAllDay(SpkrModCode="#url.spkr_id#",cfcYear="#URL.year#",cfcMonth="#URL.month#",cfcDay="#URL.day#");
		
		//Put the Meeting Time Selected by the User in an array
		MeetingTime = Available.setMeetingHours(cfcBeginTime="#MilitaryTime[1]#",cfcEndTime="#MilitaryTime[2]#");
		
		//See if either person has a conflict with the hours pulled from the funtion above
		ModConflict = Available.getConflict(SpkrModCode="#url.mod_id#",TimeSelected="#MeetingTime#");
		SpkrConflict = Available.getConflict(SpkrModCode="#url.spkr_id#",TimeSelected="#MeetingTime#");

	
	</cfscript>
	<!--- if there are no existing meetings scheduled for this day, insert the requested meeting --->
	<cfif #ModConflict# EQ false>
		<cfif #SpkrConflict# EQ false>
			<CFIF check.recordcount LT 1>
				
			
				<CFQUERY DATASOURCE="#application.projdsn#" NAME="insert">			
					INSERT INTO schedule_meeting_time(meeting_date_id, project_code, moderator_id,speaker_id,year,month,day,start_time,end_time, remarks)
					VALUES(#url.rowid#, '#session.project_code#', #url.mod_id#, #url.spkr_id#, #url.year#, #url.month#, #url.day#, '#MilitaryTime[1]#', '#MilitaryTime[2]#', '#url.remark#');
				</CFQUERY>
				
				<!----This component set the moderator time to unavailable.---->
				<cfinvoke 
					component="cfc_checkdates" 
					method="UpdateUnavailable"
					savemonth="#url.month#"
					saveyear="#url.year#"
					id="#url.mod_id#"
					userid="#session.userinfo.rowid#"
					today="#createodbcdate(Now())#"
				>
				
				<!----This component set the speaker time to unavailable.---->
				<cfinvoke 
					component="cfc_checkdates" 
					method="UpdateUnavailable"
					savemonth="#url.month#"
					saveyear="#url.year#"
					id="#url.spkr_id#"
					userid="#session.userinfo.rowid#"
					today="#createodbcdate(Now())#"
				>
				
			<!--- if there are existing meetings, check that the requested meeting does not conflict --->		
			<CFELSE>
			
				<CFSET array2d=ArrayNew(2)>
					<!--- set array with currently scheduled meeting info --->
					<CFLOOP QUERY="check">
						<CFSET array2d[CurrentRow][1] = #check.start_time#>
						<CFSET array2d[CurrentRow][2] = #check.end_time#>
						<CFSET array2d[CurrentRow][3] = #check.moderator_id#>
						<CFSET array2d[CurrentRow][4] = #check.speaker_id#>
					</CFLOOP>
		
				<cfoutput>
				<!--- found represents a conflicting meeting --->
				<CFSET found=0>
				<!--- loop through existing records and compare to requested meeting --->
				<cfloop from="1" to="#ArrayLen(array2d)#" index="x" step="1">
				<!--- #array2d[x][1]# - #url.begin_time# - #found# - #array2d[x][3]# - #url.mod_id# - #array2d[x][4]# - #url.spkr_id#<br> --->
		
					<!--- 1. If an existing meeting's begin time is equal to the requested begin time or end time...  --->
					<CFIF array2d[x][1] EQ #MilitaryTime[1]# OR array2d[x][2] EQ #MilitaryTime[2]#>
		
						<!--- If an existing meeting's moderator and speaker ARE equal to the requested moderator and speaker, set the found variable to 1  --->
						<CFIF array2d[x][3] EQ #url.mod_id# OR array2d[x][4] EQ #url.spkr_id#>
							<CFSET found=1>
						</CFIF>
					</cfif>
							
				</CFLOOP>
		
		
				<!--- After loop is complete, if no info is conflicting, insert new meeting --->
				<cfif found EQ 0>
					<CFQUERY DATASOURCE="#application.projdsn#" NAME="insert">			
						INSERT INTO schedule_meeting_time(meeting_date_id, project_code, moderator_id,speaker_id,year,month,day,start_time,end_time,remarks)
						VALUES(#url.rowid#, '#Trim(url.project_code)#', #url.mod_id#, #url.spkr_id#, #url.year#, #url.month#, #url.day#, '#MilitaryTime[1]#', '#MilitaryTime[2]#', '#url.remark#');
					</CFQUERY>
					
					<!----This component set the moderator time to unavailable.---->
					<cfinvoke 
						component="cfc_checkdates" 
						method="UpdateUnavailable"
						savemonth="#url.month#"
						saveyear="#url.year#"
						id="#url.mod_id#"
						userid="#session.userinfo.rowid#"
						today="#createodbcdate(Now())#"
					>
					
					<!----This component set the speaker time to unavailable.---->
					<cfinvoke 
						component="cfc_checkdates" 
						method="UpdateUnavailable"
						savemonth="#url.month#"
						saveyear="#url.year#"
						id="#url.spkr_id#"
						userid="#session.userinfo.rowid#"
						today="#createodbcdate(Now())#"
					>
				<!--- If conclicting info was found, put up an error --->			
				<cfelse>	
					This meeting could not be added due to a scheduling conflict!<br>
					<cfoutput>
						<form action="meeting_time_add.cfm?no_menu=1&day=#Day#&month=#month#&year=#year#" method="post">
						<INPUT TYPE="hidden" NAME="refresh" Value="0">
						<input type="submit"  value="Back" name="back">
						</form>
					</cfoutput>
					<cfabort>
				</cfif>
				</cfoutput>
			</CFIF>
		<cfelse><!----There is speaker scheduling conflict----->
			<center><div style="font-size: 16px; font-family: arial; font-weight: bold; padding-bottom: 7px; color: navy;" width="100%">Schedule Conflict</div></center>
			<center>This meeting could not be added due to a scheduling conflict!<br>
			The SPEAKER is unavailable at this time.<br>
				
				<cfscript>
				
					oSpeakers = createObject("component","cfc_pull_alternates");
		
					CurrentCode_s = oSpeakers.getCode(#session.Project_code#);
					CurrProdSpeakers = oSpeakers.getAlternates(cfcClientCode="#CurrentCode_s#",cfcType="SPKR");
									
				</cfscript>
				
				The following speakers may provide an alternative:<br>
				<table width="100%" cellpadding="0" cellspacing="0" border="0" style="margin-top: 6px; font-family: arial;">
					<tr>
						<td style="border-bottom: solid 1px navy; padding-bottom: 3px; font-size: 11px; font-weight: bold; color: navy;">Name</td>
						<td style="border-bottom: solid 1px navy; padding-bottom: 3px; font-size: 11px; text-align:center; font-weight: bold; color: navy;">Project</td>
						<td style="border-bottom: solid 1px navy; padding-bottom: 3px; font-size: 11px; text-align:center; font-weight: bold; color: navy;">Times</td>
					</tr>
					<cfoutput query="CurrProdSpeakers">
						<tr>
							<td style="font-size:11px; padding-bottom: 6px; font-weight: bold; text-align: left;">
								#CurrProdSpeakers.firstname# #CurrProdSpeakers.lastname#
							</td>
								<cfscript>
									//oSpeakers object is still in scope, so no need to instantiate.
									CurrentSchedule = oSpeakers.getSchedule(cfcID="#CurrProdSpeakers.speaker_id#",cfcDay="#url.day#",cfcYear="#url.year#",cfcMonth="#url.month#",cfcTime="#MeetingTime#");
								</cfscript>
							<cfif #ArrayLen(CurrentSchedule)# EQ 1>
								<td colspan="2" style="font-size:11px; padding-bottom: 6px; text-align: center;">
									#CurrentSchedule[1]#
								</td>
							<cfelse>
								<td style="font-size:11px; padding-bottom: 6px; font-weight: bold; text-align: center;">
									#CurrentSchedule[1]#
								</td>
								<td style="font-size:11px; padding-bottom: 6px; font-weight: bold; text-align: center;">
									#CurrentSchedule[2]#
								</td>
							</cfif>			
						</tr>			
					</cfoutput>
				
				</table>
				
				<cfoutput>
					<form action="meeting_time_add.cfm?no_menu=1&day=#Day#&month=#month#&year=#year#" method="post">
					<INPUT TYPE="hidden" NAME="refresh" Value="0">
					<input type="submit"  value="Back" name="back">
					</form>
				</cfoutput>
				
			</center>
				<cfabort>
		</cfif>
	<cfelse><!---There is a moderator scheduling Conflict----->
		<center><div style="font-size: 16px; font-family: arial; font-weight: bold; padding-bottom: 7px; color: navy;" width="100%">Schedule Conflict</div>
			This meeting could not be added due to a scheduling conflict!<br>
			The MODERATOR <cfif #SpkrConflict#>AND SPEAKER are<cfelse>is</cfif> unavailable at this time.<br>
		</center>		
		<br><br>			
				<cfscript>
				
					oModerators = createObject("component","cfc_pull_alternates");
		
					CurrentCode_m = oModerators.getCode(#session.Project_code#);
					CurrProdModerators = oModerators.getAlternates(cfcClientCode="#CurrentCode_m#",cfcType="MOD");
									
				</cfscript>
				
				The following moderators may provide an alternative:<br>
				<table width="100%" cellpadding="0" cellspacing="0" border="0" style="margin-top: 6px; font-family: arial;">
					<tr>
						<td style="border-bottom: solid 1px navy; padding-bottom: 3px; font-size: 11px; font-weight: bold; color: navy;">Name</td>
						<td style="border-bottom: solid 1px navy; padding-bottom: 3px; font-size: 11px; text-align:center; font-weight: bold; color: navy;">Project</td>
						<td style="border-bottom: solid 1px navy; padding-bottom: 3px; font-size: 11px; text-align:center; font-weight: bold; color: navy;">Times</td>
					</tr>
					<cfoutput query="CurrProdModerators">
						<tr>
							<td style="font-size:11px; padding-bottom:6px; font-weight: bold; text-align: left;">
								#CurrProdModerators.firstname# #CurrProdModerators.lastname#
							</td>
								<cfscript>
									//oModerators object is still in scope, so no need to instantiate.
									CurrentSchedule = oModerators.getSchedule(cfcID="#CurrProdModerators.speaker_id#",cfcDay="#url.day#",cfcYear="#url.year#",cfcMonth="#url.month#",cfcTime="#MeetingTime#");
								</cfscript>
							<cfif #ArrayLen(CurrentSchedule)# EQ 1>
								<td colspan="2" style="font-size:11px; padding-bottom:6px; text-align: center;">
									#CurrentSchedule[1]#
								</td>
							<cfelse>
								<td style="font-size:11px; padding-bottom:6px; font-weight: bold; text-align: center;">
									#CurrentSchedule[1]#
								</td>
								<td style="font-size:11px; padding-bottom:6px; font-weight: bold; text-align: center;">
									#CurrentSchedule[2]#
								</td>
							</cfif>
							
						</tr>			
					</cfoutput>
				
				</table>
				<cfoutput>
					<form action="meeting_time_add.cfm?no_menu=1&day=#Day#&month=#month#&year=#year#" method="post">
					<INPUT TYPE="hidden" NAME="refresh" Value="0">
					<input type="submit"  value="Back" name="back">
					</form>
				</cfoutput>
			
			<cfabort>
	</cfif>
</CFIF>

<!--- Pull updated meeting times --->
<CFQUERY DATASOURCE="#application.projdsn#" NAME="Meetings">
	SELECT *
	FROM schedule_meeting_time
	WHERE Project_code = '#session.project_code#' AND year = #year# AND month = #month# AND day = #day#
	ORDER BY start_time;
</CFQUERY>
	

<!--- Display existing meeting info --->
<center><div style="font-size: 14px; font-family: arial; font-weight: bold; padding-bottom: 5px; color: navy;" width="100%">Meetings scheduled for <CFOUTPUT>#URL.month#/#URL.day#/#URL.year#</CFOUTPUT></div></center>
<TABLE BORDER="0" ALIGN="center" CELLSPACING="0" CELLPADDING="0" WIDTH="550px" style="margin-top: 6px;">
	<TR ALIGN="center">
		<TD WIDTH="100">&nbsp;</TD>
		<TD WIDTH="100">&nbsp;</TD>
		<TD WIDTH="100">&nbsp;</TD>
		<TD WIDTH="100">&nbsp;</TD>
		<TD WIDTH="75">&nbsp;</TD>
		<TD WIDTH="75">&nbsp;</TD>
	</TR>
	<CFIF meetings.recordcount GT 0>
		<TR ALIGN="center">
			<TD style="border-bottom: solid 1px #000000;"><B>Begin Time</B></TD>
			<TD style="border-bottom: solid 1px #000000;"><B>End Time</B></TD>
			<TD style="border-bottom: solid 1px #000000;"><B>Moderator</B></TD>
			<TD style="border-bottom: solid 1px #000000;"><B>Speaker</B></TD>
			<TD style="border-bottom: solid 1px #000000;"><B>Edit</B></TD>
			<TD style="border-bottom: solid 1px #000000;"><B>Delete</B></TD>		
		</TR>

		<CFOUTPUT QUERY="Meetings">
			<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="GetModerators">
				SELECT DISTINCT firstname, lastname
				FROM spkr_table
				WHERE speaker_id='#moderator_id#'; 
			</CFQUERY>
			<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="GetSpeakers">
				SELECT DISTINCT firstname, lastname
				FROM spkr_table
				WHERE speaker_id='#speaker_id#'; 
			</CFQUERY>
			
			<cfinvoke 
				component="cfc_time_conversion" 
				method="toCivilian" 
				returnVariable="CivilianTime" 
				BeginMilitary="#start_time#"
				EndMilitary="#end_time#"
			>
			
			<cfscript>
				oCivTime = createObject("component","cfc_time_conversion");
				TheTime = oCivTime.ConCatTime(#CivilianTime#);
			</cfscript>
			
			<TR ALIGN="center">
				<TD style="padding-top: 2px;"><cfif Meetings.status EQ 1><font color="##CCCCCC">#CivilianTime[1]#:#CivilianTime[2]# #CivilianTime[3]#</font><cfelse>#CivilianTime[1]#:#CivilianTime[2]# #CivilianTime[3]#</cfif></TD>
				<TD style="padding-top: 2px;"><cfif Meetings.status EQ 1><font color="##CCCCCC">#CivilianTime[4]#:#CivilianTime[5]# #CivilianTime[6]#</font><cfelse>#CivilianTime[4]#:#CivilianTime[5]# #CivilianTime[6]#</cfif></TD>
				<TD style="padding-top: 2px;"><cfif Meetings.status EQ 1><font color="##CCCCCC">#GetModerators.firstname# #GetModerators.lastname#</font><cfelse>#GetModerators.firstname# #GetModerators.lastname#</cfif></TD>
				<TD style="padding-top: 2px;"><cfif Meetings.status EQ 1><font color="##CCCCCC">#GetSpeakers.firstname# #GetSpeakers.lastname#</font><cfelse>#GetSpeakers.firstname# #GetSpeakers.lastname#</cfif></TD>
				
			<cfif Meetings.status EQ 0>	
				<form name="EditFRM" method="post" action="meeting_time_edit_popup.cfm">
					<TD style="padding-top: 2px;">
						<input type="hidden" name="modID" value="#moderator_id#">
						<input type="hidden" name="spkrID" value="#speaker_id#">
						<input type="hidden" name="uniqueID" value="#Meetings.rowid#">
						<input type="hidden" name="_year" value="#year#">
						<input type="hidden" name="_month" value="#month#">
						<input type="hidden" name="_day" value="#day#">
						<input type="hidden" name="_time" value="#TheTime#">
						<input type="hidden" name="M_Begin" value="#start_time#">
						<input type="hidden" name="M_End" value="#end_time#">
						<div id="EditButton" class="DeleteButton" onmouseover="ChangeCursor(this)" onmouseout="ChangeCursorBack(this)" onclick="EditMeeting(this)">EDIT</div></a>
					</TD>
				</form>
				<form name="deleteFRM" method="post" action="meeting_time_delete.cfm">
					<TD style="padding-top: 2px;">
						<input type="hidden" name="modID" value="#moderator_id#">
						<input type="hidden" name="spkrID" value="#speaker_id#">
						<input type="hidden" name="uniqueID" value="#Meetings.rowid#">
						<input type="hidden" name="_year" value="#year#">
						<input type="hidden" name="_month" value="#month#">
						<input type="hidden" name="_day" value="#day#">
						<div id="DeleteButton" class="DeleteButton" onmouseover="ChangeCursor(this)" onmouseout="ChangeCursorBack(this)" onclick="makesure(this)">DELETE</div></a>
					</TD>
				</form>
			<cfelse>
					<TD valign="bottom" colspan="2"><font color="##CCCCCC">This meeting is cancelled.</font></TD>
			</cfif>	
			</TR>
		</CFOUTPUT>
	<cfelse>
	<tr>
		<td colspan="6" width="550px" align="center"><strong>No meeting times have been established for this day.</strong></td>
	</tr>
	</CFIF>
</table>
<TABLE BORDER="0" ALIGN="center" CELLSPACING="0" CELLPADDING="0" WIDTH="550">	
	<TR>
		<TD colspan="6">&nbsp;</TD>
	</TR>
	<INPUT TYPE="hidden" NAME="refresh" Value="1">
	<TR>	
		<TD COLSPAN="3" ALIGN="center">
			<CFOUTPUT>
			<input type="button"  value="Add Meeting Time" name="meeting_time_button" onclick="open('meeting_time_add_popup.cfm?no_menu=1&day=#Day#&month=#month#&year=#year#', 'meeting_time', 'width=215,height=345,left=315,top=300')">
			</CFOUTPUT>
		</TD>
		<TD COLSPAN="3" ALIGN="center">
			<INPUT TYPE="button"  VALUE="Close and Refresh" ONCLICK="closeandrefresh()">
		</TD>
	</TR>
	<TR>
		<TD COLSPAN="6" ALIGN="center"><BR>
			<INPUT TYPe="button"  VALUE="   CANCEL   " NAME="" onclick="window.close()">
		</TD>
	</TR>
</TABLE>
<BR><BR>
<center><a href="javascript:OpenWindow('schedule_help.htm#meeting_time_add')"><img src="../images/help.gif" border="0"></a></center>
</BODY>
</form>
</HTML>