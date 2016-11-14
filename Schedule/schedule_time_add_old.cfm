<!--- 
	*****************************************************************************************
	Name:		meeting_time_add.cfm
	Function:	Handles data passed from the child window meeting_time_add_popup.cfm
				and checks to see if a mod or spkr will be available. Then inserts it into 
				the database and refreshes the screen to show what currently is in the 
				databse for that date.
	History:	Finalized code 8/28/01 TJS
				Update Displays Names Rather than IDs 9/6/01 TJS
	
	*****************************************************************************************
--->
<HTML>

	<HEAD>
		<TITLE>Available times for <CFOUTPUT>#URL.month#/#URL.day#/#URL.year#</CFOUTPUT></TITLE>
		
		<LINK REL=STYLESHEET HREF="PIW1STYLE.CSS" TYPE="TEXT/CSS">
		<SCRIPT>
			function closeandrefresh() 
			{
	   			
				window.opener.location.href = window.opener.location.href;
				if (window.opener.progressWindow) 
				    window.opener.progressWindow.close();
				window.close();
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
	<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="Save_Time2">
		UPDATE availability_time
		SET x1800 =#Evaluate("form.Day#count#")#, x1900 =#Evaluate("form.Day#count#")#, x2000 =#Evaluate("form.Day#count#")#, x2100 =#Evaluate("form.Day#count#")#, x2200 =#Evaluate("form.Day#count#")#, x2300 =#Evaluate("form.Day#count#")#, allday =#Evaluate("form.Day#count#")#, updated = #Now()#, updated_userid = #session.userinfo.rowid# 
		WHERE month = #URL.savemonth# AND year = #URL.saveyear# AND day = #count# AND speakerid = '#session.ID#';
	</CFQUERY>
	
 	<!--- pull all line items from ScheduleSpeaker for this date --->
		<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="check">
			SELECT *
			FROM availability_time
			WHERE speakerid = #url.id# 
			AND year = #year# 
			AND month = #month# 
			AND day = #day#;
		</CFQUERY>
			
	<!--- pull the rowid from schedule_meeting_date for this day --->		
		<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="GetRowid">			
			SELECT DISTINCT rowid, ID
			FROM availability
			WHERE year=#URL.year# 
			AND month=#URL.month#
			AND x#URL.day#=1
			AND ID = #url.ID#;
		</CFQUERY> 
		
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
		

		<CFIF check.recordcount LT 1>
			<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="insert">			
				INSERT INTO availability_time(speakerid, year, month, day, start_time, end_time)
				VALUES(#url.ID#, #url.year#, #url.month#, #url.day#, '#MilitaryTime[1]#', '#MilitaryTime[2]#');
			</CFQUERY>
	<!--- if there are existing meetings, check that the requested meeting does not conflict --->		
		<CFELSE>
			<CFSET array2d=ArrayNew(2)>
					<!--- set array with currently scheduled meeting info --->
					
					<CFLOOP QUERY="check">
						<CFSET array2d[CurrentRow][1] = #trim(check.start_time)#>
						<CFSET array2d[CurrentRow][2] = #trim(check.end_time)#>
						<!--- <CFSET array2d[CurrentRow][3] = #check.moderator_id#>
						<CFSET array2d[CurrentRow][4] = #check.speakerid#> --->
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
	<!--- <CFIF array2d[x][3] EQ #url.mod_id# OR array2d[x][4] EQ #url.spkr_id#> --->
			<CFSET found = 1>
			
	</cfif>
					
</CFLOOP>


<!--- After loop is complete, if no info is conlicting, insert new meeting --->
		<cfif found EQ 0>
			<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="insert">			
				INSERT INTO availability_time(speakerid, year, month, day, start_time, end_time)
				VALUES(#url.ID#, #url.year#, #url.month#, #url.day#, '#MilitaryTime[1]#', '#MilitaryTime[2]#');
			</CFQUERY>
<!--- If conclicting info was found, put up an error --->			
		<cfelse>	
			This time is already marked available!<br>
<cfoutput>
<form action="schedule_time_add.cfm?ID=#id#&no_menu=1&day=#Day#&month=#month#&year=#year#" method="post">
<INPUT TYPE="hidden" NAME="refresh" Value="0">
<input type="submit"  value="Back" name="back">
</form></cfoutput><cfabort>
			</cfif>
			</cfoutput>
		</CFIF>
	</CFIF>
	
	
	<!--- Pull updated meeting times --->
	<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="Meetings">
		SELECT *
		FROM availability_time
		WHERE speakerid = #url.id# AND year = #year# AND month = #month# AND day = #day#
		ORDER BY start_time;
	</CFQUERY>
	

	<!--- Display existing meeting info --->
		<TABLE BORDER="0" ALIGN="center" CELLSPACING="0" CELLPADDING="0" WIDTH="400" HEIGHT="50">
			<TR ALIGN="center">
				<TD colspan="4"><strong>Times Available</strong></TD>
			</TR>
			<TR ALIGN="center">
				<TD WIDTH="100">&nbsp;</TD>
				<TD WIDTH="100">&nbsp;</TD>
				<TD WIDTH="100">&nbsp;</TD>
				<TD WIDTH="100">&nbsp;</TD>
			</TR>
			<TR ALIGN="center">
				<TD><B>Begin Time</B></TD>
				<TD><B>End Time</B></TD>
				<TD>&nbsp;</TD>
				<!--- <TD><B>Moderator</B></TD>
				<TD><B>Speaker</B></TD> --->
			</TR>
			<CFIF meetings.recordcount GT 0>
				
			<CFOUTPUT QUERY="Meetings">
				<!--- <CFQUERY DATASOURCE="#application.speakerDSN#" NAME="GetModerators">
					SELECT DISTINCT firstname, lastname
					FROM Speaker
					WHERE speakerid='#moderator_id#'; 
				</CFQUERY>
				<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="GetSpeakers">
					SELECT DISTINCT firstname, lastname
					FROM Speaker
					WHERE speakerid='#speakerid#'; 
				</CFQUERY> --->
				<cfif allday EQ 1>
				<TR ALIGN="center">
					<TD>1800</TD>
					<td>2200*</td>
					<td><a href="" onclick="open('schedule_time_edit_popup.cfm?ID=#ID#&no_menu=1&day=#Day#&month=#month#&year=#year#&rowid=#Meetings.rowid#&start_time=#start_time#&end_time=#end_time#', 'meeting_time', 'width=215,height=275,left=315,top=300')"><strong>Edit</strong></a>
					&nbsp;&nbsp;&nbsp;<strong>Delete</strong></td>
					<td>&nbsp;</td>
				</TR>
				<cfelse>
				
				<cfinvoke 
					component="cfc_time_conversion" 
					method="toCivilian" 
					returnVariable="CivilianTime" 
					BeginMilitary="#start_time#"
					EndMilitary="#end_time#"
				>
				
				<TR ALIGN="center">
					<TD>#CivilianTime[1]#:#CivilianTime[2]# #CivilianTime[3]#</TD>
					<TD>#CivilianTime[4]#:#CivilianTime[5]# #CivilianTime[6]#</TD>
					<td><a href="" onclick="open('schedule_time_edit_popup.cfm?ID=#ID#&no_menu=1&day=#Day#&month=#month#&year=#year#&rowid=#Meetings.rowid#&start_time=#start_time#&end_time=#end_time#', 'meeting_time', 'width=215,height=275,left=315,top=300')"><strong>Edit</strong></a>
					&nbsp;&nbsp;&nbsp;<strong>Delete</strong></td>
					<td>&nbsp;</td>
				</TR>
				</cfif>
			</CFOUTPUT>
				<TR ALIGN="center">
				<TD colspan="4">&nbsp;</TD>
			</TR>
			</CFIF>
			
			<TR>
				<TD WIDTH="100">&nbsp;</TD>
				<TD WIDTH="100">&nbsp;</TD>
				<TD WIDTH="100">&nbsp;</TD>
				<TD WIDTH="100">&nbsp;</TD>
			</TR>
			<INPUT TYPE="hidden" NAME="refresh" Value="1">
			<TR>	
					<TD COLSPAN="2" ALIGN="center">
						<CFOUTPUT>
						<input type="button"  value="Add Another Time" name="schedule_time_button" onclick="open('schedule_time_add_popup.cfm?ID=#ID#&no_menu=1&day=#Day#&month=#month#&year=#year#', 'meeting_time', 'width=215,height=275,left=315,top=300')">
						</CFOUTPUT>
					</TD>
					<TD COLSPAN="2" ALIGN="center">
						<INPUT TYPE="button"  VALUE="Close and Refresh" ONCLICK="closeandrefresh()">
					</TD>
					
					
				</TR>
			<TR><TD COLSPAN="4" ALIGN="center"><BR>
						<INPUT TYPe="button"  VALUE="   CANCEL   " NAME="" onclick="window.close()">
					</TD></TR>
			
		</TABLE>
		<BR><BR>
		
	</BODY>
</form>
</HTML>