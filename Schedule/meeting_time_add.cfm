<!---
	*****************************************************************************************
	Name:		meeting_time_add.cfm
	Function:	Handles data passed from the child window meeting_time_add_popup.cfm
				and checks to see if a mod or spkr will be available. Then inserts it into
				the database and refreshes the screen to show what currently is in the
				databse for that date.
	History:	10/28/02LB	Added code to ignore spkr id = 1. THis is a dummy record for CETs. There are no speakers for CETs
				2/9/2004 LK	Added code to handle TBD mods & spkrs - TBDs are not stored in spkr/moderator db. In the meeting record, TBD mod EQ 0 and TBD spkr EQ 0

	*****************************************************************************************
--->
<cfset TitleString = "Meetings scheduled for #URL.month#/#URL.day#/#URL.year#">
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="#TitleString#" showCalendar="0">
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
				var temp_modRowID = EditFRM[i].modRowID.value;
				var temp_spkrID = EditFRM[i].spkrID.value;
				var temp_spkrRowID = EditFRM[i].spkrRowID.value;
				var temp_uniqueID = EditFRM[i].uniqueID.value;
				var temp_meeting_code = EditFRM[i].meeting_code.value;
				var temp_sequence = EditFRM[i].sequence.value;
				var temp_year = EditFRM[i]._year.value;
				var temp_month = EditFRM[i]._month.value;
				var temp_day = EditFRM[i]._day.value;
				var temp_time = EditFRM[i]._time.value;
				var temp_begin = EditFRM[i].M_Begin.value;
				var temp_end = EditFRM[i].M_End.value;
				var meeting_use = EditFRM[i].meeting_use.value;

				var pointer = "meeting_time_edit_popup.cfm?no_menu=1&year=" + temp_year + "&month=" + temp_month + "&day=" + temp_day + "&time=" + temp_time + "&modID=" + temp_modID + "&sequence=" + temp_sequence + "&modRowID=" + temp_modRowID + "&spkrID=" + temp_spkrID + "&meeting_code=" + temp_meeting_code + "&spkrRowID=" + temp_spkrRowID +  "&uniqueID=" + temp_uniqueID + "&beginM=" + temp_begin + "&EndM=" + temp_end + "&meeting_use=" + meeting_use;
				window.open(pointer, "_self");
			}
		}

	}
	else
	{
		var temp_modID = EditFRM.modID.value;
		var temp_modRowID = EditFRM.modRowID.value;
		var temp_spkrID = EditFRM.spkrID.value;
		var temp_spkrRowID = EditFRM.spkrRowID.value;
		var temp_uniqueID = EditFRM.uniqueID.value;
		var temp_meeting_code = EditFRM.meeting_code.value;
		var temp_sequence = EditFRM.sequence.value;
		var temp_year = EditFRM._year.value;
		var temp_month = EditFRM._month.value;
		var temp_day = EditFRM._day.value;
		var temp_time = EditFRM._time.value;
		var temp_begin = EditFRM.M_Begin.value;
		var temp_end = EditFRM.M_End.value;
		var meeting_use = EditFRM.meeting_use.value;

		var pointer = "meeting_time_edit_popup.cfm?no_menu=1&year=" + temp_year + "&month=" + temp_month + "&day=" + temp_day + "&time=" + temp_time + "&modID=" + temp_modID + "&sequence=" + temp_sequence + "&modRowID=" + temp_modRowID + "&spkrID=" + temp_spkrID + "&meeting_code=" + temp_meeting_code + "&spkrRowID=" + temp_spkrRowID +  "&uniqueID=" + temp_uniqueID + "&beginM=" + temp_begin + "&EndM=" + temp_end + "&meeting_use=" + meeting_use;
		window.open(pointer, "_self");
	}
}

function AddListen(oTarget)
{
	if(document.all.ListenButton.length > 1)//Is there more than one edit form on the page?
	{
		for(i=0; i<document.all.ListenButton.length; i++)//Loop through all the Edit Buttons
		{
			/*****If the edit button clicked matches a edit button in the array, submit the form
			correspondig to that place in the array.******/
			if(oTarget == document.all.ListenButton[i])
			{
				var temp_modID = listenFRM[i].modID.value;
				var temp_modRowID = listenFRM[i].modRowID.value;
				var temp_spkrID = listenFRM[i].spkrID.value;
				var temp_spkrRowID = listenFRM[i].spkrRowID.value;
				var temp_uniqueID = listenFRM[i].uniqueID.value;
				var temp_meeting_code = listenFRM[i].meeting_code.value;
				var temp_year = listenFRM[i]._year.value;
				var temp_month = listenFRM[i]._month.value;
				var temp_day = listenFRM[i]._day.value;
				var temp_time = listenFRM[i]._time.value;
				var temp_begin = listenFRM[i].M_Begin.value;
				var temp_end = listenFRM[i].M_End.value;

				var pointer = "meeting_time_listen_popup.cfm?no_menu=1&year=" + temp_year + "&month=" + temp_month + "&day=" + temp_day + "&time=" + temp_time + "&modID=" + temp_modID + "&modRowID=" + temp_modRowID + "&spkrID=" + temp_spkrID + "&meeting_code=" + temp_meeting_code + "&spkrRowID=" + temp_spkrRowID + "&uniqueID=" + temp_uniqueID + "&beginM=" + temp_begin + "&EndM=" + temp_end;
				window.open(pointer, "_self");
			}
		}

	}
	else
	{
		var temp_modID = listenFRM.modID.value;
		var temp_modRowID = listenFRM.modRowID.value;
		var temp_spkrID = listenFRM.spkrID.value;
		var temp_spkrRowID = listenFRM.spkrRowID.value;
		var temp_uniqueID = listenFRM.uniqueID.value;
		var temp_meeting_code = listenFRM.meeting_code.value;
		var temp_year = listenFRM._year.value;
		var temp_month = listenFRM._month.value;
		var temp_day = listenFRM._day.value;
		var temp_time = listenFRM._time.value;
		var temp_begin = listenFRM.M_Begin.value;
		var temp_end = listenFRM.M_End.value;

		var pointer = "meeting_time_listen_popup.cfm?no_menu=1&year=" + temp_year + "&month=" + temp_month + "&day=" + temp_day + "&time=" + temp_time + "&modID=" + temp_modID + "&modRowID=" + temp_modRowID + "&spkrID=" + temp_spkrID + "&meeting_code=" + temp_meeting_code + "&spkrRowID=" + temp_spkrRowID + "&uniqueID=" + temp_uniqueID + "&beginM=" + temp_begin + "&EndM=" + temp_end;
		window.open(pointer, "_self");
	}
}


function AddSpeaker(oTarget)
{
	if(document.all.SpeakerButton.length > 1)//Is there more than one edit form on the page?
	{
		for(i=0; i<document.all.SpeakerButton.length; i++)//Loop through all the Edit Buttons
		{
			/*****If the edit button clicked matches a edit button in the array, submit the form
			correspondig to that place in the array.******/
			if(oTarget == document.all.SpeakerButton[i])
			{
				var temp_modID = speakerFRM[i].modID.value;
				var temp_modRowID = speakerFRM[i].modRowID.value;
				var temp_spkrID = speakerFRM[i].spkrID.value;
				var temp_spkrRowID = speakerFRM[i].spkrRowID.value;
				var temp_uniqueID = speakerFRM[i].uniqueID.value;
				var temp_meeting_code = speakerFRM[i].meeting_code.value;
				var temp_year = speakerFRM[i]._year.value;
				var temp_month = speakerFRM[i]._month.value;
				var temp_day = speakerFRM[i]._day.value;
				var temp_time = speakerFRM[i]._time.value;
				var temp_begin = speakerFRM[i].M_Begin.value;
				var temp_end = speakerFRM[i].M_End.value;

				var pointer = "meeting_time_speaker_popup.cfm?no_menu=1&year=" + temp_year + "&month=" + temp_month + "&day=" + temp_day + "&time=" + temp_time + "&meeting_code=" + temp_meeting_code + "&modID=" + temp_modID + "&modRowID=" + temp_modRowID + "&spkrID=" + temp_spkrID + "&spkrRowID=" + temp_spkrRowID + "&uniqueID=" + temp_uniqueID + "&beginM=" + temp_begin + "&EndM=" + temp_end;
				window.open(pointer, "_self");
			}
		}

	}
	else
	{
		var temp_modID = speakerFRM.modID.value;
		var temp_modRowID = speakerFRM.modRowID.value;
		var temp_spkrID = speakerFRM.spkrID.value;
		var temp_spkrRowID = speakerFRM.spkrRowID.value;
		var temp_uniqueID = speakerFRM.uniqueID.value;
		var temp_meeting_code = speakerFRM.meeting_code.value;
		var temp_year = speakerFRM._year.value;
		var temp_month = speakerFRM._month.value;
		var temp_day = speakerFRM._day.value;
		var temp_time = speakerFRM._time.value;
		var temp_begin = speakerFRM.M_Begin.value;
		var temp_end = speakerFRM.M_End.value;

		var pointer = "meeting_time_speaker_popup.cfm?no_menu=1&year=" + temp_year + "&month=" + temp_month + "&day=" + temp_day + "&meeting_code=" + temp_meeting_code + "&time=" + temp_time + "&modID=" + temp_modID + "&modRowID=" + temp_modRowID + "&spkrID=" + temp_spkrID + "&spkrRowID=" + temp_spkrRowID + "&uniqueID=" + temp_uniqueID + "&beginM=" + temp_begin + "&EndM=" + temp_end;
		window.open(pointer, "_self");
	}
}


function AddTraining(oTarget)
{
	if(document.all.TrainingButton.length > 1)//Is there more than one edit form on the page?
	{
		for(i=0; i<document.all.TrainingButton.length; i++)//Loop through all the Edit Buttons
		{
			/*****If the edit button clicked matches a edit button in the array, submit the form
			correspondig to that place in the array.******/
			if(oTarget == document.all.TrainingButton[i])
			{
				var temp_modID = trainingFRM[i].modID.value;
				var temp_modRowID = trainingFRM[i].modRowID.value;
				var temp_spkrID = trainingFRM[i].spkrID.value;
				var temp_spkrRowID = trainingFRM[i].spkrRowID.value;
				var temp_uniqueID = trainingFRM[i].uniqueID.value;
				var temp_meeting_code = trainingFRM[i].meeting_code.value;
				var temp_year = trainingFRM[i]._year.value;
				var temp_month = trainingFRM[i]._month.value;
				var temp_day = trainingFRM[i]._day.value;
				var temp_time = trainingFRM[i]._time.value;
				var temp_begin = trainingFRM[i].M_Begin.value;
				var temp_end = trainingFRM[i].M_End.value;

				var pointer = "meeting_time_training_popup.cfm?no_menu=1&year=" + temp_year + "&month=" + temp_month + "&day=" + temp_day + "&time=" + temp_time + "&modID=" + temp_modID + "&modRowID=" + temp_modRowID + "&meeting_code=" + temp_meeting_code + "&spkrID=" + temp_spkrID + "&spkrRowID=" + temp_spkrRowID + "&uniqueID=" + temp_uniqueID + "&beginM=" + temp_begin + "&EndM=" + temp_end;
				window.open(pointer, "_self");
			}
		}

	}
	else
	{
		var temp_modID = trainingFRM.modID.value;
		var temp_modRowID = trainingFRM.modRowID.value;
		var temp_spkrID = trainingFRM.spkrID.value;
		var temp_spkrRowID = trainingFRM.spkrRowID.value;
		var temp_uniqueID = trainingFRM.uniqueID.value;
		var temp_meeting_code = trainingFRM.meeting_code.value;
		var temp_year = trainingFRM._year.value;
		var temp_month = trainingFRM._month.value;
		var temp_day = trainingFRM._day.value;
		var temp_time = trainingFRM._time.value;
		var temp_begin = trainingFRM.M_Begin.value;
		var temp_end = trainingFRM.M_End.value;

		var pointer = "meeting_time_training_popup.cfm?no_menu=1&year=" + temp_year + "&month=" + temp_month + "&meeting_code=" + temp_meeting_code + "&day=" + temp_day + "&time=" + temp_time + "&modID=" + temp_modID + "&modRowID=" + temp_modRowID + "&spkrID=" + temp_spkrID + "&spkrRowID=" + temp_spkrRowID + "&uniqueID=" + temp_uniqueID + "&beginM=" + temp_begin + "&EndM=" + temp_end;
		window.open(pointer, "_self");
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
</SCRIPT>

<CFSET year = URL.year>
<CFSET month = URL.month>
<CFSET day = URL.day>

<!---Build a Date Object---->
<cfset fulldate = #CreateDate(year, month, day)#>


<!--- Saves then refreshes all data inputted from the above form --->
<CFPARAM NAME="url.refresh" DEFAULT="0">

<CFIF "#URL.refresh#" EQ '1'>
	<cfset SpkrConflict = 'false'>
	<cfset ModConflict = 'false'>

	<!----STEP 1  Put Component here to convert from Civilian to Military Time.
	This returns an array.  The [1] position is the begin time and the [2] position is
	end time.---->
	<cfinvoke
		component="pms.com.cfc_time_conversion"
		method="toMilitary"
		returnVariable="MilitaryTime"
		BeginHour="#trim(url.begin_hour)#"
		BeginMinute="#trim(url.begin_minute)#"
		BeginMeridiem="#trim(url.begin_meridiem)#"
		EndHour="#trim(url.end_hour)#"
		EndMinute="#trim(url.end_minute)#"
		EndMeridiem="#trim(url.end_meridiem)#"
	>

	<!--- STEP 1.5   Check to see if the sequence letter has already been used. If it has, put up an error message --->
			<CFQUERY DATASOURCE="#application.projdsn#" NAME="getSequence">
				SELECT sequence
				FROM schedule_meeting_time
				WHERE project_code = '#session.project_code#' 
				AND year = #year# 
				AND month = #month#
				AND day = #day# 
				AND start_time = #MilitaryTime[1]# 
				AND end_time = #MilitaryTime[2]# 
				AND status = 0 
				AND sequence = '#url.sequence#'
			</cfquery>

			<cfif getSequence.recordcount>
			<cfoutput>
					<cfset TimeCreated1 = CreateTime(Left(MilitaryTime[1], 2),Right(MilitaryTime[1],2),00)>
					<cfset TimeCreated2 = CreateTime(Left(MilitaryTime[2], 2),Right(MilitaryTime[2],2),00)>
				<font size="1" face="Verdana, Arial, Helvetica, sans-serif">
				Sequence <strong>#url.sequence#</strong> is already assigned to a <strong>#session.project_code#</strong> meeting from
				<strong>#TimeFormat(TimeCreated1,'h:mmtt')# - #TimeFormat(TimeCreated2,'h:mmtt')#.</strong>
				<br>Please choose the next letter in the sequence.
				</font>
						<form action="meeting_time_add.cfm?no_menu=1&day=#Day#&month=#month#&year=#year#" method="post">
						<INPUT TYPE="hidden" NAME="refresh" Value="0">
						<input type="submit" value="Back" name="back">
						</form>
			</cfoutput>
				<cfabort>
			</cfif>




	<!----STEP 2   Matt Eaves 12/23/02
	Because mod and speakers are slected based on honoraria amounts, the rowid from speaker_clients is
	passed as the mod_id and spkr_id.  Need to set variables containing speaker and moderator unique
	ids.------>
	<cfif #url.spkr_row_id# NEQ 1 AND #url.spkr_row_id# NEQ 0>
		<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="GetSpeakerID">
			SELECT owner_id FROM speaker_clients WHERE rowid = #url.spkr_row_id#
		</cfquery>
		<cfset giSpeakerId = #GetSpeakerID.owner_id#>
		<cfset giSpeakerRowId = #url.spkr_row_id#>
	<cfelse>
		<!--- if speaker is not needed for this meeting type, set the variables, don't pull info from db --->
		<cfif url.spkr_row_id EQ 1>
			<cfset giSpeakerId = 1>
			<cfset giSpeakerRowId = 0>
		<!--- if speaker is TBD, set the variables, don't pull info from db --->
		<cfelse>
			<cfset giSpeakerId = 0>
			<cfset giSpeakerRowId = 0>
		</cfif>
	</cfif>

	<!--- STEP 3 ------------------------------------------------------------------->
	<cfif #url.mod_row_id# NEQ 0>
		<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="GetModeratorID">
			SELECT owner_id FROM speaker_clients WHERE rowid = #url.mod_row_id#
		</cfquery>
			<cfset giModeratorId = #GetModeratorID.owner_id#>
			<cfset giModeratorRowId = #url.mod_row_id#>
	<!--- if mod is TBD, set the variables, don't pull info from db --->
	<cfelse>
		<cfset giModeratorId = 0>
		<cfset giModeratorRowId = 0>
	</cfif>


	<cfscript>
		//Create Object
		Available = createObject("component","pms.com.cfc_check_available");
		//Step 4 -------------------------------------------------------------
		//Put the Meeting Time Selected by the User in an array
		MeetingTime = Available.setMeetingHours(cfcBeginTime="#MilitaryTime[1]#",cfcEndTime="#MilitaryTime[2]#");


		//Get Moderator and Speaker Day Availability
		//Step 5 -------------------------------------------------------------
		//See if either person has a conflict with the hours pulled from the funtion above
		//if mod_id is not equal to 0 (TBD), check mod availability
		if(not "#giModeratorId#" EQ 0)
		{
		ModConflict = Available.getConflict(SpkrModCode="#giModeratorId#",TimeSelected="#MeetingTime#",Year="#year#",Month="#month#",Day="#day#");
		}
		//if spkr_id is not equal to 1 (event w/o spkr) AND not equal to 0 (TBD), check speaker availability
		if(not "#giSpeakerId#" EQ 1 AND not "#giSpeakerID#" EQ 0)
		{
			SpkrConflict = Available.getConflict(SpkrModCode="#giSpeakerId#",TimeSelected="#MeetingTime#",Year="#year#",Month="#month#",Day="#day#");
		}

	</cfscript>
	<!--- set array of requested meeting times to list --->
	<cfset TimeList = #ArraytoList(MeetingTime)#>
	<!--- count the number of 1/2 hour increments --->
	<cfset TimeListLen = #listLen(TimeList,",")#>
	<!--- remove the end time from the list --->
	<cfset EditTimeList1 = ListDeleteAt(TimeList,#TimeListLen#,',')>
	<!--- remove the start time from the list --->
	<cfset EditTimeList = #ListDeleteAt(EditTimeList1,1,',')#>
	<!--- Step 6------------------------------------------------------------------------->
	<!--- pull all line items from schedule_meeting_time for this date --->
	<CFQUERY DATASOURCE="#application.projdsn#" NAME="check">
		SELECT *
		FROM schedule_meeting_time
		WHERE Project_code = '#session.project_code#' AND year = #year# AND month = #month#
		AND day = #day# AND status = 0
		AND (staff_id = #giModeratorId# OR staff_id = #giSpeakerId#) AND staff_id != 0
		<cfif EditTimeList NEQ "">
		AND (start_time IN (#EditTimeList#) OR end_time IN (#EditTimeList#))
		<cfelse>
		AND (start_time = #MilitaryTime[1]# OR start_time = #MilitaryTime[2]#)
		</cfif>
	</CFQUERY>

<!--- check for other meetings to set meeting code --->
	<CFQUERY DATASOURCE="#application.projdsn#" NAME="getMeetingCode">
		SELECT MAX(rtrim(meeting_code)) AS max_meeting_code
		FROM schedule_meeting_time
		WHERE Project_code = '#session.project_code#' AND year = #year# AND month = #month#
		AND day = #day#
		AND start_time = #MilitaryTime[1]#
		AND end_time = #MilitaryTime[2]#
	</CFQUERY>

	<!--- <cfoutput query="getMeetingCode">Max:#max_meeting_code#<br><cfabort></cfoutput> --->
	<!--- if there are no existing meetings scheduled for this day, insert the requested meeting --->
	<cfif #ModConflict# EQ false>
		<cfif #SpkrConflict# EQ false>
			<CFIF check.recordcount LT 1>
				<!--- set meeting_code variable, if meeting exists for this time, increment 1 --->
				<cfif len(getMeetingCode.max_meeting_code)GT 0>
					<cfset x = right(trim(getMeetingCode.max_meeting_code),1)>
					<cfset x = x + 1>
					<cfset meeting_code = trim(project_code) & month & day & year & MilitaryTime[1] & x>
				<cfelse>
					<cfset meeting_code = trim(project_code) & month & day & year & MilitaryTime[1] & '1'>
				</cfif>
				<CFQUERY DATASOURCE="#application.projdsn#" NAME="insertmod">
					INSERT INTO schedule_meeting_time(meeting_date_id, meeting_code, project_code, moderator_id, speaker_id, staff_id, staff_type, year,month,day,start_time,end_time, remarks, meeting_date, mod_client_rowid, client_rowid, use_type, sequence)
					VALUES(#url.rowid#, '#meeting_code#', '#session.project_code#', #giModeratorId#, #giSpeakerId#, #giModeratorId#, 1,  #url.year#, #url.month#, #url.day#, '#MilitaryTime[1]#', '#MilitaryTime[2]#', '#url.remark#', #fulldate#, #url.mod_row_id#, #url.mod_row_id#, #url.meeting_use#, '#url.sequence#');
				</CFQUERY>

					<!--- *****************************************************************
					Add rows to Evaluations table. eval_type 1 = mod, eval_type 2 = intercall
					11/3/2003 LK
					************************************************************************ --->
						<CFQUERY DATASOURCE="#application.projdsn#" NAME="inserteval1">
							INSERT INTO Evaluations (meeting_code, eval_type)
							VALUES('#meeting_code#', 1);
						</CFQUERY>

						<CFQUERY DATASOURCE="#application.projdsn#" NAME="inserteval2">
							INSERT INTO Evaluations (meeting_code, eval_type)
							VALUES('#meeting_code#', 2);
						</CFQUERY>
					<!--- ***************************************************************** --->

				<cfif giSpeakerID NEQ 1<!---  AND giSpeakerID NEQ 0 --->>
				<CFQUERY DATASOURCE="#application.projdsn#" NAME="insertspkr">
					INSERT INTO schedule_meeting_time(meeting_date_id, meeting_code, project_code, speaker_id, moderator_id, staff_id, staff_type, year,month,day,start_time,end_time, remarks, meeting_date, spkr_client_rowid, client_rowid, use_type, sequence)
					VALUES(#url.rowid#, '#meeting_code#', '#session.project_code#', #giSpeakerId#, #giModeratorId#, #giSpeakerId#, 2, #url.year#, #url.month#, #url.day#, '#MilitaryTime[1]#', '#MilitaryTime[2]#', '#url.remark#', #fulldate#, #giSpeakerRowId#, #giSpeakerRowId#, #url.meeting_use#, '#url.sequence#');
				</CFQUERY>
				</cfif>

				<!----This component set the moderator time to unavailable.---->
				<cfinvoke
					component="pms.com.cfc_checkdates"
					method="UpdateUnavailable"
					savemonth="#url.month#"
					saveyear="#url.year#"
					id="#giModeratorId#"
					userid="#session.userinfo.rowid#"
					today="#createodbcdate(Now())#"
				>

				<!----This component set the speaker time to unavailable.---->
				<cfinvoke
					component="pms.com.cfc_checkdates"
					method="UpdateUnavailable"
					savemonth="#url.month#"
					saveyear="#url.year#"
					id="#giSpeakerId#"
					userid="#session.userinfo.rowid#"
					today="#createodbcdate(Now())#"
				>

				<!--- runs function to edit number of meetings in meeting summary table --->
				<cfinvoke
					component="pms.com.cfc_meeting_summary"
					method="updateSummary"
					action="update"
					project_code="#session.project_code#"
					meeting_date="#fulldate#"
					meeting_year="#url.year#"
				>



				<!--- *************************************** --->

			<!--- Display conflict --->
			<!--- <CFELSE> --->

				<!--- <CFSET array2d=ArrayNew(2)>
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
				<!--- #array2d[x][1]# - #url.begin_time# - #found# - #array2d[x][3]# - #giModeratorId# - #array2d[x][4]# - #giSpeakerId#<br> --->

					<!--- 1. If an existing meeting's begin time is equal to the requested begin time or end time...  --->
					<CFIF array2d[x][1] EQ #MilitaryTime[1]# OR array2d[x][2] EQ #MilitaryTime[2]#>

						<!--- If an existing meeting's moderator and speaker ARE equal to the requested moderator and speaker, set the found variable to 1  --->
						<CFIF array2d[x][3] EQ #giModeratorId# OR (array2d[x][4] EQ #giSpeakerId# AND giSpeakerId NEQ 1)>
							<CFSET found=1>
						</CFIF>
					</cfif>

				</CFLOOP>


				<!--- After loop is complete, if no info is conflicting, insert new meeting --->
				<cfif found EQ 0>
					<CFQUERY DATASOURCE="#application.projdsn#" NAME="insert">
						INSERT INTO schedule_meeting_time(meeting_date_id, project_code, moderator_id,speaker_id,year,month,day,start_time,end_time,remarks,meeting_date,mod_client_rowid,spkr_client_rowid)
						VALUES(#url.rowid#, '#Trim(url.project_code)#', #giModeratorId#, #giSpeakerId#, #url.year#, #url.month#, #url.day#, '#MilitaryTime[1]#', '#MilitaryTime[2]#', '#url.remark#', #fulldate#, #url.mod_row_id#, #giSpeakerRowId#);
					</CFQUERY>

					<!----This component set the moderator time to unavailable.---->
					<cfinvoke
						component="cfc_checkdates"
						method="UpdateUnavailable"
						savemonth="#url.month#"
						saveyear="#url.year#"
						id="#giModeratorId#"
						userid="#session.userinfo.rowid#"
						today="#createodbcdate(Now())#"
					>


					<!----This component set the speaker time to unavailable.---->
					<cfinvoke
						component="cfc_checkdates"
						method="UpdateUnavailable"
						savemonth="#url.month#"
						saveyear="#url.year#"
						id="#giSpeakerId#"
						userid="#session.userinfo.rowid#"
						today="#createodbcdate(Now())#"
					>

					<!--- runs function to edit number of meetings in meeting summary table --->
					<cfinvoke
						component="cfc_meeting_summary"
						method="updateSummary"
						action="update"
						project_code="#session.project_code#"
						meeting_date="#fulldate#"
						meeting_year="#url.year#"
					>
					 --->
					<!--- ********************************************************* --->



				<!--- If conclicting info was found, put up an error --->
				<cfelse>
					<!--- <cfoutput>#ModConflict#:#SpkrConflict#**<br>
					#giModeratorId#
					</cfoutput><br>
					<cfdump var="#MeetingTime#"> --->
					<cfoutput query="check">
						<cfif staff_id EQ giModeratorID>
						This meeting could not be added due to a MODERATOR scheduling conflict!<br>
						</cfif>
						<cfif staff_id EQ giSpeakerID>
						This meeting could not be added due to a SPEAKER scheduling conflict!<br>
						</cfif>

					</cfoutput>
					<cfoutput>
						<form action="meeting_time_add.cfm?no_menu=1&day=#Day#&month=#month#&year=#year#" method="post">
						<INPUT TYPE="hidden" NAME="refresh" Value="0">
						<input type="submit" value="Back" name="back">
						</form>
					</cfoutput>
					<cfabort>
				</cfif>
<!--- 				</cfoutput> --->
			<!--- </CFIF> --->
		<cfelse><!----There is speaker scheduling conflict----->
			<center><div style="font-size: 16px; font-family: arial; font-weight: bold; padding-bottom: 7px; color: navy;" width="100%">Schedule Conflict</div></center>
			<center>This meeting could not be added due to a scheduling conflict!<br>
			The SPEAKER is unavailable at this time.<br>
					<cfoutput>#MilitaryTime[1]#, #MilitaryTime[2]#</cfoutput>
				<cfscript>

					oSpeakers = createObject("component","pms.com.cfc_pull_alternates");

					CurrentCode_s = oSpeakers.getCode(#session.Project_code#);
					CurrProdSpeakers = oSpeakers.getAlternates(cfcClientCode="#CurrentCode_s#",cfcType="SPKR");

				</cfscript>

				The following speakers may provide an alternative:<br>
				<table cellpadding="0" cellspacing="0" border="0" style="margin-top: 6px; font-family: arial;">
					<tr>
						<td width="150" style="border-bottom: solid 1px navy; padding-bottom: 3px; font-size: 11px; font-weight: bold; color: navy;">Name</td>
						<td width="100" style="border-bottom: solid 1px navy; padding-bottom: 3px; font-size: 11px; text-align:center; font-weight: bold; color: navy;">Project</td>
						<td width="300" style="border-bottom: solid 1px navy; padding-bottom: 3px; font-size: 11px; text-align:center; font-weight: bold; color: navy;">Times</td>
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

				</table>

				<cfoutput>
					<form action="meeting_time_add.cfm?no_menu=1&day=#Day#&month=#month#&year=#year#" method="post">
					<INPUT TYPE="hidden" NAME="refresh" Value="0">
					<input type="submit" value="Back" name="back">
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
							<td style="font-size:11px; padding-bottom:6px; font-weight: bold; text-align: left;">
								#CurrProdModerators.firstname# #CurrProdModerators.lastname#
							</td>
								<cfscript>
									//oModerators object is still in scope, so no need to instantiate.
									CurrentSchedule = oModerators.getSchedule(cfcID="#CurrProdModerators.speaker_id#",cfcDay="#url.day#",cfcYear="#url.year#",cfcMonth="#url.month#",cfcTime="#MeetingTime#");
								</cfscript>
							<cfif #ArrayLen(CurrentSchedule)# EQ 1>
								<td>&nbsp;</td>
								<td style="font-size:11px; padding-bottom:6px; text-align: center;">
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
				<center>
					<cfoutput>
						<form action="meeting_time_add.cfm?no_menu=1&day=#Day#&month=#month#&year=#year#" method="post">
						<INPUT TYPE="hidden" NAME="refresh" Value="0">
						<input type="submit" value="Back" name="back">
						</form>
					</cfoutput>
				</center>

			<cfabort>
	</cfif>


</CFIF>
<!------------------------------------------------------------------------------------
		Display existing meetings
 ---------------------------------------------------------------------------------------->
<!--- Pull updated meeting times --->
<CFQUERY DATASOURCE="#application.projdsn#" NAME="Meetings">
	SELECT m.meeting_code, m.use_type, m.project_code, m.year, m.month, m.day, m.rowid, m.start_time, m.end_time, m.staff_id AS moderator_id, m.client_rowid AS moderator_client, m.status, m.sequence, s.staff_id AS speaker_id, s.client_rowid AS speaker_client, mt.firstname + ' ' + mt.lastname AS mod_name, mf.fee
	FROM PMSProd.dbo.schedule_meeting_time m, PMSProd.dbo.schedule_meeting_time s, speaker.dbo.spkr_table mt, speaker.dbo.speaker_clients mf
	WHERE m.project_code = '#session.project_code#' AND m.year = #year# AND m.month = #month# AND m.day = #day# AND m.staff_type = 1 AND m.staff_id *= mt.speaker_id AND m.staff_id *= mf.owner_id AND
	(m.meeting_code *= s.meeting_code AND s.staff_type = 2)
	ORDER BY m.meeting_code, s.start_time
</CFQUERY>


<!--- Display existing meeting info --->
<center><div style="font-size: 14px; font-family: arial; font-weight: bold; padding-bottom: 5px; color: navy;" width="100%"><cfoutput>#session.project_code#</cfoutput><br>Meetings scheduled for <CFOUTPUT>#URL.month#/#URL.day#/#URL.year#</CFOUTPUT></div></center>
<TABLE BORDER="0" ALIGN="center" CELLSPACING="0" CELLPADDING="0" WIDTH="630px" style="margin-top: 6px;">
	<TR ALIGN="center">
		<TD WIDTH="75">&nbsp;</TD>
		<TD WIDTH="75">&nbsp;</TD>
		<TD WIDTH="60">&nbsp;</TD>
		<TD WIDTH="125">&nbsp;</TD>
		<TD WIDTH="125">&nbsp;</TD>
		<TD WIDTH="60">&nbsp;</TD>
		<TD WIDTH="60">&nbsp;</TD>
		<TD WIDTH="60">&nbsp;</TD>
		<TD WIDTH="60">&nbsp;</TD>
	</TR>
	<CFIF meetings.recordcount GT 0>
		<TR ALIGN="center">
			<TD style="border-bottom: solid 1px #000000;"><B>Begin Time</B></TD>
			<TD style="border-bottom: solid 1px #000000;"><B>End Time</B></TD>
			<TD style="border-bottom: solid 1px #000000;"><B>Sequence</B></TD>
			<TD style="border-bottom: solid 1px #000000;"><B>Moderator</B></TD>
			<TD style="border-bottom: solid 1px #000000;"><B>Speaker</B></TD>
			<TD style="border-bottom: solid 1px #000000;"><B>Edit</B></TD>
			<TD style="border-bottom: solid 1px #000000;"><B>Delete</B></TD>
			<TD style="border-bottom: solid 1px #000000;"><B>Speaker</B></TD>
			<TD style="border-bottom: solid 1px #000000;"><B>ListenIns</B></TD>
			<TD style="border-bottom: solid 1px #000000;"><B>Training</B></TD>
		</TR>

		<CFOUTPUT QUERY="Meetings" group="meeting_code">

			<!--- Pull updated meeting times --->
			<CFQUERY DATASOURCE="#application.projdsn#" NAME="Getspeaker">
				SELECT s.staff_id AS speaker_id, s.client_rowid AS speaker_client, st.firstname + ' ' + st.lastname AS speaker_name, sf.fee
				FROM PMSProd.dbo.schedule_meeting_time s, speaker.dbo.spkr_table st, speaker.dbo.speaker_clients sf
				WHERE s.meeting_code = '#Meetings.meeting_code#' AND s.staff_type = 2 AND s.staff_id = st.speaker_id AND s.staff_id = sf.owner_id
</CFQUERY>


<!--- EDITED TSWIFT 20041110
<CFQUERY DATASOURCE="#application.projdsn#" NAME="Getspeaker">
SELECT max(sf.fee) as fee, s.staff_id AS speaker_id, s.client_rowid AS speaker_client, st.firstname + ' ' + st.lastname AS speaker_name
FROM PMSProd.dbo.schedule_meeting_time s, speaker.dbo.spkr_table st, speaker.dbo.speaker_clients sf
WHERE s.meeting_code = '#Meetings.meeting_code#' AND s.staff_type = 2 AND s.staff_id = st.speaker_id AND s.staff_id = sf.owner_id
group by s.staff_id ,s.client_rowid,st.firstname,st.lastname
</CFQUERY>
--->


			<!--- <cfif Meetings.speaker_id NEQ "" AND Meetings.speaker_id NEQ 1>
			<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="GetSpeakers">
				SELECT st.firstname, st.lastname, sc.fee
				FROM spkr_table st, speaker_clients sc
				WHERE speaker_id = #Meetings.speaker_id#
				AND sc.rowid = #Meetings.speaker_client#
			</CFQUERY>
				<cfset speaker_name = #trim(GetSpeakers.firstname)# & ' ' & #GetSpeakers.lastname#>
				<cfset speaker_fee = #GetSpeakers.fee#>
			<cfelse>
				<cfset speaker_name = ''>
				<cfset speaker_fee = ''>
			</cfif> --->

			<cfinvoke
				component="pms.com.cfc_time_conversion"
				method="toCivilian"
				returnVariable="CivilianTime"
				BeginMilitary="#start_time#"
				EndMilitary="#end_time#"
			>

			<cfscript>
				oCivTime = createObject("component","pms.com.cfc_time_conversion");
				TheTime = oCivTime.ConCatTime(#CivilianTime#);
			</cfscript>

			<TR ALIGN="center">
				<TD style="padding-top: 2px;">
					<cfif Meetings.status EQ 1><font color="##CCCCCC">#CivilianTime[1]#:#CivilianTime[2]# #CivilianTime[3]#</font>
					<cfelse>
						#CivilianTime[1]#:#CivilianTime[2]# #CivilianTime[3]#
						<cfif Meetings.use_type EQ 1>
						<font color="##0066FF">Train.</font>
						</cfif>
					</cfif></TD>
				<TD style="padding-top: 2px;"><cfif Meetings.status EQ 1><font color="##CCCCCC">#CivilianTime[4]#:#CivilianTime[5]# #CivilianTime[6]#</font><cfelse>#CivilianTime[4]#:#CivilianTime[5]# #CivilianTime[6]#</cfif></TD>
				<TD style="padding-top: 2px;">#Meetings.sequence#</TD>
				<TD style="padding-top: 2px;">
				<cfif Meetings.status EQ 1>
					<cfif Meetings.moderator_id EQ 0>
					<font color="##CCCCCC">TBD</font>
					<cfelse>
					<font color="##CCCCCC">#Meetings.mod_name# - #DollarFormat(Meetings.fee)#</font>
					</cfif>
				<cfelse>
					<cfif Meetings.moderator_id EQ 0>
					TBD
					<cfelse>
					#Meetings.mod_name# - #DollarFormat(Meetings.fee)#
					</cfif>
				</cfif>
				</TD>
				<TD style="padding-top: 2px;">
				<cfif Getspeaker.recordcount>
				<cfif Meetings.status EQ 1>
					<cfif Meetings.speaker_id EQ 0>
					<font color="##CCCCCC">TBD</font>
					<cfelse>
					<font color="##CCCCCC">#Getspeaker.speaker_name# - #DollarFormat(Getspeaker.fee)#</font>
					</cfif>
				<cfelse>
					<cfif Meetings.speaker_id EQ 0>
					TBD
					<cfelse>
					#Getspeaker.speaker_name# - #DollarFormat(Getspeaker.fee)#
					</cfif>
				</cfif>
				<cfelse>
					<cfif Meetings.speaker_id EQ 0>
					TBD
					<cfelse>
					N/A
					</cfif>
				</cfif>
				</TD>

			<cfif Meetings.status EQ 0>
				<form name="EditFRM" method="post" action="meeting_time_edit_popup.cfm">
					<TD style="padding-top: 2px;">
						<input type="hidden" name="meeting_code" value="#trim(Meetings.meeting_code)#">
						<input type="hidden" name="sequence" value="#trim(Meetings.sequence)#">
						<input type="hidden" name="modID" value="#moderator_id#">
						<input type="hidden" name="modRowID" value="#Meetings.moderator_client#">
						<input type="hidden" name="spkrID" value="#speaker_id#">
						<input type="hidden" name="spkrRowID" value="#Meetings.speaker_client#">
						<input type="hidden" name="uniqueID" value="#Meetings.rowid#">
						<input type="hidden" name="_year" value="#year#">
						<input type="hidden" name="_month" value="#month#">
						<input type="hidden" name="_day" value="#day#">
						<input type="hidden" name="_time" value="#TheTime#">
						<input type="hidden" name="M_Begin" value="#start_time#">
						<input type="hidden" name="M_End" value="#end_time#">
						<input type="hidden" name="meeting_use" value="#Meetings.use_type#">
						<div id="EditButton" class="DeleteButton" onmouseover="ChangeCursor(this)" onmouseout="ChangeCursorBack(this)" onclick="EditMeeting(this)">EDIT</div></a>
					</TD>
				</form>
				<form name="deleteFRM" method="post" action="meeting_time_delete.cfm">
					<TD style="padding-top: 2px;">
						<input type="hidden" name="modID" value="#moderator_id#">
						<input type="hidden" name="spkrID" value="#speaker_id#">
						<input type="hidden" name="uniqueID" value="#Meetings.rowid#">
						<input type="hidden" name="meeting_code" value="#Meetings.meeting_code#">
						<input type="hidden" name="_year" value="#year#">
						<input type="hidden" name="_month" value="#month#">
						<input type="hidden" name="_day" value="#day#">
						<input type="hidden" name="meetingdate" value="#fulldate#">
						<div id="DeleteButton" class="DeleteButton" onmouseover="ChangeCursor(this)" onmouseout="ChangeCursorBack(this)" onclick="makesure(this)">DELETE</div></a>
					</TD>
				</form>
				<form name="speakerFRM" method="post" action="meeting_time_speaker.cfm">
					<TD style="padding-top: 2px;">
						<input type="hidden" name="modID" value="#moderator_id#">
						<input type="hidden" name="modRowID" value="#Meetings.moderator_client#">
						<input type="hidden" name="meeting_code" value="#Meetings.meeting_code#">
						<input type="hidden" name="spkrID" value="#speaker_id#">
						<input type="hidden" name="spkrRowID" value="#Meetings.speaker_client#">
						<input type="hidden" name="uniqueID" value="#Meetings.rowid#">
						<input type="hidden" name="_year" value="#year#">
						<input type="hidden" name="_month" value="#month#">
						<input type="hidden" name="_day" value="#day#">
						<input type="hidden" name="_time" value="#TheTime#">
						<input type="hidden" name="M_Begin" value="#start_time#">
						<input type="hidden" name="M_End" value="#end_time#">
						<div id="SpeakerButton" class="DeleteButton" onmouseover="ChangeCursor(this)" onmouseout="ChangeCursorBack(this)" onclick="AddSpeaker(this)">ADD</div></a>
					</TD>
				</form>
				<form name="listenFRM" method="post" action="meeting_time_listen.cfm">
					<TD style="padding-top: 2px;">
						<input type="hidden" name="modID" value="#moderator_id#">
						<input type="hidden" name="meeting_code" value="#Meetings.meeting_code#">
						<input type="hidden" name="modRowID" value="#Meetings.moderator_client#">
						<input type="hidden" name="spkrID" value="#speaker_id#">
						<input type="hidden" name="spkrRowID" value="#Meetings.speaker_client#">
						<input type="hidden" name="uniqueID" value="#Meetings.rowid#">
						<input type="hidden" name="_year" value="#year#">
						<input type="hidden" name="_month" value="#month#">
						<input type="hidden" name="_day" value="#day#">
						<input type="hidden" name="_time" value="#TheTime#">
						<input type="hidden" name="M_Begin" value="#start_time#">
						<input type="hidden" name="M_End" value="#end_time#">
						<div id="ListenButton" class="DeleteButton" onmouseover="ChangeCursor(this)" onmouseout="ChangeCursorBack(this)" onclick="AddListen(this)">ADD</div></a>
					</TD>
				</form>
				<form name="trainingFRM" method="post" action="meeting_time_training.cfm">
					<TD style="padding-top: 2px;">
						<input type="hidden" name="modID" value="#moderator_id#">
						<input type="hidden" name="modRowID" value="#Meetings.moderator_client#">
						<input type="hidden" name="spkrID" value="#speaker_id#">
						<input type="hidden" name="spkrRowID" value="#Meetings.speaker_client#">
						<input type="hidden" name="uniqueID" value="#Meetings.rowid#">
						<input type="hidden" name="meeting_code" value="#Meetings.meeting_code#">
						<input type="hidden" name="_year" value="#year#">
						<input type="hidden" name="_month" value="#month#">
						<input type="hidden" name="_day" value="#day#">
						<input type="hidden" name="_time" value="#TheTime#">
						<input type="hidden" name="M_Begin" value="#start_time#">
						<input type="hidden" name="M_End" value="#end_time#">
						<div id="TrainingButton" class="DeleteButton" onmouseover="ChangeCursor(this)" onmouseout="ChangeCursorBack(this)" onclick="AddTraining(this)">ADD</div></a>
					</TD>
				</form>
			<cfelse>
					<TD valign="bottom" colspan="4"><font color="##CCCCCC">This meeting is cancelled.</font></TD>
			</cfif>
			</TR>
		</CFOUTPUT>
	<cfelse>
	<tr>
		<td colspan="8" width="550px" align="center"><strong>No meeting times have been established for this day.</strong></td>
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
			<input type="button" value="Add Meeting Time" name="meeting_time_button" onclick="open('meeting_time_add_popup.cfm?no_menu=1&day=#Day#&month=#month#&year=#year#', 'meeting_time', 'width=240,height=480,left=200,top=150, resize')">
			</CFOUTPUT>
		</TD>
		<TD COLSPAN="3" ALIGN="center">
			<INPUT TYPE="button" VALUE="Close and Refresh" ONCLICK="closeandrefresh()">
		</TD>
	</TR>
	<TR>
		<TD COLSPAN="6" ALIGN="center"><BR>
			<INPUT TYPe="button" VALUE="   CANCEL   " NAME="" onclick="window.close()">
		</TD>
		<!--- <TD><cfoutput>
			<cfif #ListFindNoCase("#session.nospeaker#", "#right(session.project_code,2)#")# GT 0>Yes<cfelse>No</cfif>
		</cfoutput>
		</TD> --->
	</TR>
</TABLE>
<BR><BR>
</form>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">