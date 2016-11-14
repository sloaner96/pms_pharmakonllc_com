<!--------
meeting_time_edit_action_final.cfm

Sets old Speaker and Mod to available then sets new speaker and mod to unavilable and updates the meeting.

10/14/02 -- Matt Eaves -- Initial Code
01/14/2005 - Ben Jurevicius - added update for 'remarks column in schedule_meeting_time table.

--------------------->

<html>
<head><title>Meeting Schedule</title>
<script language="JavaScript">
function GoBack()
{
	<cfoutput>
	url2="meeting_time_add.cfm?no_menu=1&refresh=0&day=#form.txtday#&month=#form.txtmonth#&year=#form.txtyear#"
	</cfoutput>
	window.open(url2, "_self");
}
</script>
</head>
<body>

<cfparam name="ModeratorSame" default="false">
<cfparam name="SpeakerSame" default="false">

<!-----Step 1 - Check to See if Meeting is Cancelled
		value of 1 means meeting was cancelled, zero means the meeting was NOT canceled
	   ------------------------------------->
<cfif #form.Cancel# EQ 0>

<!----Step2 - Matt Eaves 12/30/02
	Because mod and speakers are slected based on honoraria amounts, the rowid from speaker_clients is
	passed as the mod_id and spkr_id.  Need to set variables containing speaker and moderator unique
	ids.-------------------------------------------->

	<!--- updates the notes field --->
	<CFQUERY DATASOURCE="#application.projdsn#" NAME="updtaeNotes">
		UPDATE schedule_meeting_time SET remarks = '#trim(FORM.notes)#'
		WHERE rowid = #FORM.uniqueID#
	</CFQUERY>

	<cfif form.GetSpeakers NEQ 1 AND form.GetSpeakers NEQ 0>
		<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="GetSpeakerID">
		SELECT owner_id FROM speaker_clients WHERE rowid = #form.GetSpeakers#
		</cfquery>
		<cfset giSpeakerId = #GetSpeakerID.owner_id#>
		<cfset giSpeakerRowId = #form.GetSpeakers#>
	<cfelse>
		<!--- if speaker is not needed for this meeting type... --->
		<cfif form.GetSpeakers EQ 1>
			<cfset giSpeakerId = 1>
			<cfset giSpeakerRowId = 0>
		<!--- if speaker is TBD... --->
		<cfelse>
			<cfset giSpeakerId = 0>
			<cfset giSpeakerRowId = 0>
		</cfif>
	</cfif>

<!--- Step3 - Because mod and speakers are slected based on honoraria amounts, the rowid from speaker_clients is
	passed as the mod_id and spkr_id.  Need to set variables containing speaker and moderator unique
	ids. --->
	<cfif form.GetModerators NEQ 0>
		<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="GetModeratorID">
			SELECT owner_id FROM speaker_clients WHERE rowid = #form.GetModerators#
		</cfquery>
			<cfset giModeratorId = #GetModeratorID.owner_id#>
			<cfset giModeratorRowId = #form.GetModerators#>
	<!--- if moderator is TBD --->
	<cfelse>
			<cfset giModeratorId = 0>
			<cfset giModeratorRowId = 0>
	</cfif>

	<!-----Step4 - First, make sure that a change to the original speaker and or moderator was made.  If it wasn't,
	there is no need to check availablity because that person will definitely be unavailable.  Only when a
	change is made do we want to check availablity------->
	<CFQUERY DATASOURCE="#application.projdsn#" NAME="GetMod">
		SELECT client_rowid, rowid, meeting_code
		FROM schedule_meeting_time
		<!--- WHERE Project_code = '#session.project_code#' AND year = #form.txtyear# AND month = #form.txtmonth# AND day = #form.txtday# AND start_time = #form.MilitaryTimeBegin# AND end_time = #form.MilitaryTimeEnd#  AND staff_type = 1 --->
		WHERE meeting_code = '#form.meeting_code#' AND staff_type = 1
	</CFQUERY>

	<CFQUERY DATASOURCE="#application.projdsn#" NAME="GetSpkr">
		SELECT client_rowid, rowid, meeting_code
		FROM schedule_meeting_time
		<!--- WHERE Project_code = '#session.project_code#' AND year = #form.txtyear# AND month = #form.txtmonth# AND day = #form.txtday# AND start_time = #form.MilitaryTimeBegin# AND end_time = #form.MilitaryTimeEnd# AND staff_type = 2 --->
		WHERE meeting_code = '#form.meeting_code#' AND staff_type = 2
	</CFQUERY>


	<!--- STEP 4.5   Check to see if the sequence letter has already been used. If it has, put up an error message --->
		<cfif form.sequence NEQ form.Getsequence>
			<CFQUERY DATASOURCE="#application.projdsn#" NAME="getSequence">
				SELECT sequence
				FROM schedule_meeting_time
				WHERE project_code = '#session.project_code#' AND year = #txtyear# AND month = #txtmonth#
					AND day = #txtday# AND start_time = #form.MilitaryTimeBegin# AND end_time = #form.MilitaryTimeEnd#
					AND status = 0 AND sequence = '#form.Getsequence#' AND rowid != #GetMod.rowid#
					<cfif GetSpkr.recordcount>
					AND rowid != #GetSpkr.rowid#
					</cfif>
			</cfquery>

			<cfif getSequence.recordcount>
			<cfoutput>
					<cfset TimeCreated1 = CreateTime(Left(form.MilitaryTimeBegin, 2),Right(form.MilitaryTimeBegin,2),00)>
					<cfset TimeCreated2 = CreateTime(Left(form.MilitaryTimeEnd, 2),Right(form.MilitaryTimeEnd,2),00)>
				<font size="1" face="Verdana, Arial, Helvetica, sans-serif">
				Sequence <strong>#form.Getsequence#</strong> is already assigned to a <strong>#session.project_code#</strong> meeting from
				<strong>#TimeFormat(TimeCreated1,'h:mmtt')# - #TimeFormat(TimeCreated2,'h:mmtt')#.</strong>
				<br>Please choose the next letter in the sequence.
				</font><br><br>
						<INPUT TYPe="button" VALUE="   Go Back   " NAME="" onclick="GoBack()">
			</cfoutput>
				<cfabort>
			</cfif>
		</cfif>



	<!----------------------- Update Meeting Use Type --------------------------------------------->
	<cfoutput>
	<cfscript>
				oUpdate = createObject("component","pms.com.cfc_delete_update_meeting");
				MeetingUpdate = oUpdate.UpdateUseType(meeting_code="#GetMod.meeting_code#",meeting_use="#form.meeting_use#");
	</cfscript>
	</cfoutput>


	<!----Set variable to set up which code to run further down the page---->
	<cfif #GetMod.client_rowid# EQ #form.GetModerators#>
		<cfset ModeratorSame = true>
	<cfelse>
		<cfset ModeratorSame = false>
	</cfif>

	<cfif #GetSpkr.client_rowid# EQ #form.GetSpeakers#>
		<cfset SpeakerSame = true>
	<cfelse>
		<cfset SpeakerSame = false>
	</cfif>

	<!----To avoid a mess of if statements below, when we are working with a non-speaker program,
	we just set the SpeakerSame to true.------>
	<cfif #giSpeakerId# EQ 1>
		<cfset SpeakerSame = true>
	</cfif>

	<!--- <cfoutput>sp:#SpeakerSame# &nbsp;&nbsp;mo:#ModeratorSame#<br>
	#GetMod.client_rowid#-#form.GetModerators#-#giModeratorRowId#<br>
	#GetSpkr.client_rowid#-#form.GetSpeakers#-#giSpeakerRowId#
	</cfoutput> --->


	<!----These next set of if's will run the moderator and/or speaker conflict objects
	if needed.  This will ensure no false positives on schedule conflicts (i.e. Bart Test being scheduled for
	meeting 195 and then user does an edit but leaves Bart Test as speaker.  If we run scedule conflict check,
	Bart will have conflict because the components check to see if bart is available.  He will be unavailable
	because he is scheduled for meeting 195, eventhough that is the meeting we are editing.  To avoid this
	we only run check when there is a change in speaker/moderator----->

	<cfif SpeakerSame EQ false AND ModeratorSame EQ false><!-----Step6 - Different Spkr and Mod are selected.  Check both schedules--->
		<cfscript>
			//Create Object
			Available = createObject("component","pms.com.cfc_check_available");

			//Get Moderator and Speaker Day Availability
			//ModAvail = Available.getAllDay(SpkrModCode="#giModeratorId#",cfcYear="#form.txtyear#",cfcMonth="#form.txtmonth#",cfcDay="#form.txtday#");
			//SpkrAvail = Available.getAllDay(SpkrModCode="#giSpeakerId#",cfcYear="#form.txtyear#",cfcMonth="#form.txtmonth#",cfcDay="#form.txtday#");

			//Put the Meeting Time Selected by the User in an array
			MeetingTime = Available.setMeetingHours(cfcBeginTime="#MilitaryTimeBegin#",cfcEndTime="#MilitaryTimeEnd#");

			//See if either person has a conflict with the hours pulled from the funtion above
			//if(not "#giModeratorId#" EQ 0)
			//{
			ModConflict = Available.getConflict(SpkrModCode="#giModeratorId#",TimeSelected="#MeetingTime#",Year="#form.txtyear#",Month="#form.txtmonth#",Day="#form.txtday#");
			//}
			//if(not "#giSpeakerId#" EQ 0)
			//{
			SpkrConflict = Available.getConflict(SpkrModCode="#giSpeakerId#",TimeSelected="#MeetingTime#",Year="#form.txtyear#",Month="#form.txtmonth#",Day="#form.txtday#");
			//}
		</cfscript>

	<cfelseif SpeakerSame EQ true AND ModeratorSame EQ false><!-----Different Mod is selected.  Check Mod schedule--->
		<cfscript>
			//Create Object
			Available = createObject("component","pms.com.cfc_check_available");

			//Get Moderator and Speaker Day Availability
			//ModAvail = Available.getAllDay(SpkrModCode="#giModeratorId#",cfcYear="#form.txtyear#",cfcMonth="#form.txtmonth#",cfcDay="#form.txtday#");

			//Put the Meeting Time Selected by the User in an array
			MeetingTime = Available.setMeetingHours(cfcBeginTime="#MilitaryTimeBegin#",cfcEndTime="#MilitaryTimeEnd#");

			//See if either person has a conflict with the hours pulled from the funtion above
			//if(not "#giModeratorId#" EQ 0)
			//{
			ModConflict = Available.getConflict(SpkrModCode="#giModeratorId#",TimeSelected="#MeetingTime#",Year="#form.txtyear#",Month="#form.txtmonth#",Day="#form.txtday#");
			//}
			SpkrConflict = false;
		</cfscript>

	<cfelseif SpeakerSame EQ false AND ModeratorSame EQ true><!-----Different Spkr is selected.  Check Spkr schedule--->
		<cfscript>
			//Create Object
			Available = createObject("component","pms.com.cfc_check_available");

			//Get Moderator and Speaker Day Availability
			//SpkrAvail = Available.getAllDay(SpkrModCode="#giSpeakerId#",cfcYear="#form.txtyear#",cfcMonth="#form.txtmonth#",cfcDay="#form.txtday#");

			//Put the Meeting Time Selected by the User in an array
			MeetingTime = Available.setMeetingHours(cfcBeginTime="#MilitaryTimeBegin#",cfcEndTime="#MilitaryTimeEnd#");

			//See if either person has a conflict with the hours pulled from the funtion above
			ModConflict = false;
			//if(not "#giSpeakerId#" EQ 0)
			//{
			SpkrConflict = Available.getConflict(SpkrModCode="#giSpeakerId#",TimeSelected="#MeetingTime#",Year="#form.txtyear#",Month="#form.txtmonth#",Day="#form.txtday#",cfcBeginTime="#MilitaryTimeBegin#",cfcEndTime="#MilitaryTimeEnd#");
			//}
		</cfscript>

	<cfelseif SpeakerSame EQ true AND ModeratorSame EQ true><!----Nothing has changed, run below code anyways---->
		<cfscript>
			ModConflict = false;
			SpkrConflict = false;
		</cfscript>
	</cfif>

	<!--- Step10 --->
	<cfif #ModConflict# EQ false>
		<cfif #SpkrConflict# EQ false>
			<!----To avoid a bunch of if statements, just set Both the original Speaker and Moderator to
			available even if the original Speaker and Moderator are the same as the ones selected by the
			user.  Then set the selected Speaker/Mod to unavailable using cfc_chedkdates component---->
				<cfif form.sequence NEQ form.Getsequence>
				<!--- If there is not a sequence conflict, update the sequence --->
				<CFQUERY DATASOURCE="#application.projdsn#" NAME="UpdateModSequence">
					UPDATE schedule_meeting_time
						SET sequence = '#form.Getsequence#'
					WHERE rowid = #GetMod.rowid#
				</CFQUERY>
				</cfif>
			<cfscript>
				//Need to set old Speaker and Mod to avilable
				oUpdate = createObject("component","pms.com.cfc_delete_update_meeting");
				MeetingDetails = oUpdate.MakeAvailable(Meeting_Code="#GetMod.meeting_code#",UserID="#session.userinfo.rowid#");
				MeetingUpdate = oUpdate.UpdateMeeting(Row_ID="#GetMod.rowid#",Staff_ID="#giModeratorId#",staff_rowid="#giModeratorRowId#");
			</cfscript>
			<cfif GetSpkr.recordcount>
					<cfif form.sequence NEQ form.Getsequence>
				<!--- If there is not a sequence conflict, update the sequence --->
				<CFQUERY DATASOURCE="#application.projdsn#" NAME="UpdateSpkrSequence">
					UPDATE schedule_meeting_time
						SET sequence = '#form.Getsequence#'
					WHERE rowid = #GetSpkr.rowid#
				</CFQUERY>
				</cfif>

			<cfscript>
			MeetingUpdate = oUpdate.UpdateMeeting(Row_ID="#GetSpkr.rowid#",Staff_ID="#giSpeakerId#",staff_rowid="#giSpeakerRowId#");
			</cfscript>
			</cfif>

			<!----This component set the moderator time to unavailable.---->
			<!--- <cfif giModeratorId NEQ 0> --->
			<cfinvoke
				component="pms.com.cfc_checkdates"
				method="UpdateUnavailable"
				savemonth="#form.txtmonth#"
				saveyear="#form.txtyear#"
				id="#giModeratorId#"
				userid="#session.userinfo.rowid#"
				today="#createodbcdate(Now())#"
			>
			<!--- </cfif> --->

			<!----This component set the speaker time to unavailable.---->
			<!--- <cfif giSpeakerID NEQ 0> --->
			<cfinvoke
				component="pms.com.cfc_checkdates"
				method="UpdateUnavailable"
				savemonth="#form.txtmonth#"
				saveyear="#form.txtyear#"
				id="#giSpeakerId#"
				userid="#session.userinfo.rowid#"
				today="#createodbcdate(Now())#"
			>
			<!--- </cfif> --->

		<cflocation url="meeting_time_add.cfm?no_menu=1&month=#form.txtMonth#&year=#form.txtYear#&day=#form.txtDay#" addtoken="no">

		<cfelse><!----There is speaker scheduling conflict----->
			<center><div style="font-size: 16px; font-family: arial; font-weight: bold; padding-bottom: 7px; color: navy;" width="100%">Schedule Conflict</div></center>
			<center>This meeting could not be added due to a scheduling conflict!<br>
			The SPEAKER is unavailable at this time.<br>
				<cfscript>

					oSpeakers = createObject("component","pms.com.cfc_pull_alternates");

					CurrentCode_s = oSpeakers.getCode(#session.Project_code#);
					CurrProdSpeakers = oSpeakers.getAlternates(cfcClientCode="#CurrentCode_s#",cfcType="SPKR");

				</cfscript>

				The following speakers may provide an alternative:<br>
				<table cellpadding="0" cellspacing="0" border="0" style="margin-top: 6px; font-family: arial;">
					<tr>
						<td width="150" style="border-bottom: solid 1px navy; padding-bottom: 3px; font-size: 11px; color: navy; font-weight: bold;">Name</td>
						<td width="100" style="border-bottom: solid 1px navy; padding-bottom: 3px; font-size: 11px; color: navy; font-weight: bold; text-align:center;">Project</td>
						<td width="300" style="border-bottom: solid 1px navy; padding-bottom: 3px; font-size: 11px; color: navy; font-weight: bold; text-align:center;">Times</td>
					</tr>
					<cfoutput query="CurrProdSpeakers">
						<tr>
							<td style="font-size:11px; padding-bottom: 6px; font-weight: bold; text-align: left;">
								#CurrProdSpeakers.firstname# #CurrProdSpeakers.lastname#
							</td>
								<cfscript>
									//oSpeakers object is still in scope, so no need to instantiate.
									CurrentSchedule = oSpeakers.getSchedule(cfcID="#CurrProdSpeakers.speaker_id#",cfcYear="#form.txtyear#",cfcMonth="#form.txtmonth#",cfcDay="#form.txtday#",cfcTime="#MeetingTime#");
								</cfscript>
							<cfif #ArrayLen(CurrentSchedule)# EQ 1>
								<td>&nbsp;</td>
								<td style="font-size:11px; padding-bottom: 6px; text-align: center;">
									#CurrentSchedule[1]#
								</td>
							<cfelse>
								<td style="font-size:11px; padding-bottom: 6px; font-weight: bold; text-align:center; ">
									#CurrentSchedule[1]#
								</td>
								<td style="font-size:11px; padding-bottom: 6px; font-weight: bold; text-align:center; ">
									#CurrentSchedule[2]#
								</td>
							</cfif>
						</tr>
					</cfoutput>
						<tr>
							<td style="padding-top: 8px; text-align: center;" colspan="3"><INPUT TYPe="button" VALUE="   Go Back   " NAME="" onclick="GoBack()"></td>
						</tr>
				</table>
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

				oModerators = createObject("component","pms.com.cfc_pull_alternates");

				CurrentCode_m = oModerators.getCode(#session.Project_code#);
				CurrProdModerators = oModerators.getAlternates(cfcClientCode="#CurrentCode_m#",cfcType="MOD");

			</cfscript>

			The following moderators may provide an alternative:<br>
			<table cellpadding="0" cellspacing="0" border="0" style="margin-top: 6px; font-family: arial;">
				<tr>
					<td width="150" style="border-bottom: solid 1px navy; padding-bottom: 3px; font-size: 11px; font-weight: bold; color: navy;">Name</td>
					<td width="100" style="border-bottom: solid 1px navy; padding-bottom: 3px; font-size: 11px; text-align:center; font-weight: bold; color: navy;">Project</td>
					<td width="300" style="border-bottom: solid 1px navy; padding-bottom: 3px; font-size: 11px; text-align:center; font-weight: bold; color: navy;">Times</td>
				</tr>
				<cfoutput query="CurrProdModerators">
					<tr>
						<td style="font-size:11px; padding-bottom: 6px; font-weight: bold; text-align: left;">
							#CurrProdModerators.firstname# #CurrProdModerators.lastname#
						</td>
							<cfscript>
								//oModerators object is still in scope, so no need to instantiate.
								CurrentSchedule = oModerators.getSchedule(cfcID="#CurrProdModerators.speaker_id#",cfcYear="#form.txtyear#",cfcMonth="#form.txtmonth#",cfcDay="#form.txtday#",cfcTime="#MeetingTime#");
							</cfscript>
						<cfif #ArrayLen(CurrentSchedule)# EQ 1>
							<td>&nbsp;</td>
							<td style="font-size:11px; padding-bottom: 6px; text-align: center;">
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
					<tr>
						<td style="padding-top: 8px; text-align: center;" colspan="3"><INPUT TYPe="button" VALUE="   Go Back   " NAME="" onclick="GoBack()"></td>
					</tr>
			</table>
			<cfabort>
	</cfif>

<cfelse><!----Meeting was cancelled---->


	<CFQUERY DATASOURCE="#application.projdsn#" NAME="CancelMeeting">
		UPDATE schedule_meeting_time
		SET status = 1
		<!--- WHERE rowid = #form.UniqueID# --->
		WHERE meeting_code = '#form.meeting_code#'
	</CFQUERY>

	<CFQUERY DATASOURCE="#application.projdsn#" NAME="PullMeetingDate">
		SELECT DISTINCT meeting_date, year
		FROM schedule_meeting_time
		<!--- WHERE rowid = #form.UniqueID# --->
		WHERE meeting_code = '#form.meeting_code#'
	</CFQUERY>

	<!--- runs function to edit number of meetings in meeting summary table --->
	<cfinvoke
		component="pms.com.cfc_meeting_summary"
		method="updateSummary"
		action="delete"
		project_code="#session.project_code#"
		meeting_date="#PullMeetingDate.meeting_date#"
		meeting_year="#PullMeetingDate.year#"
	>


	<!----Now lets Set the Speaker, Moderator, Additional Speakers, and Listen In's, available for those times----->
	<cfoutput>
	<cfscript>
		//Need to set Speaker, Mod, listenins, trainees, and additional spkrs to available
		oUpdate2 = createObject("component","pms.com.cfc_delete_update_meeting");
		oUpdate2.MakeAvailable(Row_ID="#form.UniqueID#",UserID="#session.userinfo.rowid#",meeting_code="#form.meeting_code#");
		//oUpdate2.MakeAdditionSpkrAvailable(Row_ID="#form.UniqueID#",UserID="#session.userinfo.rowid#");
		//oUpdate2.MakeListenInsAvailable(Row_ID="#form.UniqueID#",UserID="#session.userinfo.rowid#");
	</cfscript>
	</cfoutput>
	<cflocation url="meeting_time_add.cfm?no_menu=1&month=#form.txtMonth#&year=#form.txtYear#&day=#form.txtDay#" addtoken="no">

</cfif>

</body>
</html>

