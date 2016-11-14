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
		<TITLE>Meetings scheduled for <CFOUTPUT>#URL.month#/#URL.day#/#URL.year#</CFOUTPUT></TITLE>
		
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
<cfif url.refresh EQ 0>test</cfif>

	<CFSET year = URL.year>
	<CFSET month = URL.month>
	<CFSET day = URL.day>	
		
	<!--- Saves then refreshes all data inputted from the above form --->
	<CFPARAM NAME="url.refresh" DEFAULT="0">
	<CFIF "#URL.refresh#" EQ '1'>
	<!--- pull all line items from schedule_meeting_time for this date --->
		<CFQUERY DATASOURCE="#application.projdsn#" NAME="check">
			SELECT *
			FROM schedule_meeting_time
			WHERE Project_code = '#session.project_code#' 
			AND year = #year# 
			AND month = #month# 
			AND day = #day#;
		</CFQUERY>
			
	<!--- pull the rowid from schedule_meeting_date for this day --->		
		<CFQUERY DATASOURCE="#application.projdsn#" NAME="GetRowid">			
			SELECT DISTINCT rowid, project_code
			FROM schedule_meeting_date
			WHERE year=#URL.year# 
			AND month=#URL.month#
			AND x#URL.day#=1
			AND project_code = '#session.project_code#';
		</CFQUERY>
		
		<!--- if there are no existing meetings scheduled for this day, insert the requested meeting --->
<CFIF check.recordcount LT 1>
			<CFQUERY DATASOURCE="#application.projdsn#" NAME="insert">			
				INSERT INTO schedule_meeting_time(meeting_date_id, project_code, moderator_id,speaker_id,year,month,day,start_time,end_time)
				VALUES(#url.rowid#, '#session.project_code#', #url.mod_id#, #url.spkr_id#, #url.year#, #url.month#, #url.day#, '#Trim(url.begin_time)#', '#Trim(url.end_time)#');
			</CFQUERY>
	<!--- if there are existing meetings, check that the requested meeting does not conflict --->		
		<CFELSE>
			<!--- <CFSET rowcounter=1>--->
			<cfoutput><CFSET ROWTOTAL=#check.recordcount#></cfoutput> 
			<CFSET array2d=ArrayNew(2)>
					
			<!--- <CFLOOP CONDITION="rowcounter LESS THAN OR EQUAL TO ROWTOTAL"> --->
					<!--- set array with records scheduled meeting info --->
				<CFLOOP QUERY="check">
					<CFSET array2d[CurrentRow][1] = #start_time#>
					<CFSET array2d[CurrentRow][2] = #check.end_time#>
					<CFSET array2d[CurrentRow][3] = #check.moderator_id#>
					<CFSET array2d[CurrentRow][4] = #check.speaker_id#>
				</CFLOOP>
				<!--- <CFSET rowcounter=rowcounter+1>
			</CFLOOP> --->
			
			<CFSET rowcounter=1>
			<CFSET found=0>
	<CFLOOP Query="check">
				<!--- 1. If an existing meeting's begin time is equal to the requested begin time or end time...  --->
				<CFIF array2d[rowcounter][1] EQ #url.begin_time# OR array2d[rowcounter][2] EQ #url.end_time#>
				<!--- If an existing meeting's moderator and speaker ARE NOT equal to the requested moderator and speaker...  --->
						<CFIF array2d[rowcounter][3] EQ #url.mod_id# OR array2d[rowcounter][4] EQ #url.spkr_id#>
				This meeting could not be added due to a scheduling conflict!<br>
<cfoutput>
<form action="meeting_time_add.cfm?no_menu=1&day=#Day#&month=#month#&year=#year#&refresh=0" method="post">
<!--- <INPUT TYPE="hidden" NAME="refresh" Value="0"> --->
<input type="submit"  value="Back" name="back">
<cfset found = 1>
</form></cfoutput><cfabort>
					</CFIF>
		<cfelse>		
				<!--- insert the meeting --->
			<CFQUERY DATASOURCE="#application.projdsn#" NAME="insert">			
					INSERT INTO schedule_meeting_time(meeting_date_id, project_code, moderator_id,speaker_id,year,month,day,start_time,end_time)
					VALUES(#url.rowid#, '#Trim(url.project_code)#', #url.mod_id#, #url.spkr_id#, #url.year#, #url.month# , #url.day# , '#Trim(url.begin_time)#', '#Trim(url.end_time)#');
			</CFQUERY>			
			</CFLOOP>
			
			<cfelse>		
				<!--- insert the meeting --->
			<CFQUERY DATASOURCE="#application.projdsn#" NAME="insert">			
					INSERT INTO schedule_meeting_time(meeting_date_id, project_code, moderator_id,speaker_id,year,month,day,start_time,end_time)
					VALUES(#url.rowid#, '#Trim(url.project_code)#', #url.mod_id#, #url.spkr_id#, #url.year#, #url.month# , #url.day# , '#Trim(url.begin_time)#', '#Trim(url.end_time)#');
			</CFQUERY>
		</CFIF> 
		
		
	</CFIF>
	<CFQUERY DATASOURCE="#application.projdsn#" NAME="Meetings">
		SELECT *
		FROM schedule_meeting_time
		WHERE Project_code = '#session.project_code#' AND year = #year# AND month = #month# AND day = #day#
		ORDER BY start_time;
	</CFQUERY>
	

	
		<TABLE BORDER="0" ALIGN="center" CELLSPACING="0" CELLPADDING="0" WIDTH="400" HEIGHT="50">
			<TR ALIGN="center">
				<TD WIDTH="100">&nbsp;</TD>
				<TD WIDTH="100">&nbsp;</TD>
				<TD WIDTH="100">&nbsp;</TD>
				<TD WIDTH="100">&nbsp;</TD>
			</TR>
			<TR ALIGN="center">
				<TD><B>Begin Time</B></TD>
				<TD><B>End Time</B></TD>
				<TD><B>Moderator</B></TD>
				<TD><B>Speaker</B></TD>
			</TR>
			<CFIF meetings.recordcount GT 0>
				
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
				<TR ALIGN="center">
					<TD>#start_time#</TD>
					<TD>#end_time#</TD>
					<TD>#GetModerators.firstname# #GetModerators.lastname#</TD>
					<TD>#GetSpeakers.firstname# #GetSpeakers.lastname#</TD>
				</TR>
			</CFOUTPUT>
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
						<input type="button"  value="Add Meeting Time" name="meeting_time_button" onclick="open('meeting_time_add_popup.cfm?no_menu=1&day=#Day#&month=#month#&year=#year#', 'meeting_time', 'width=215,height=275,left=315,top=300')">
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