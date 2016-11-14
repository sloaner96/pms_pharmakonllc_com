<!---------------------------------
report_modspkr_calendar2.cfm

This report is an Outlook type calendar that will display meetings for a particular 
spkr/mod or times a spkr/mod is unavailable. 

11/14/02 - Matt Eaves - Initial Code
--------------------------------------->
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Moderator/Speaker Calendar" showCalendar="0">

<style>
SPAN.CalInfoSpan
{
	font-family: arial;
	font-size: 9px;
}

DIV.HidePrintSpaces
{
	display: none;
}

DIV.ShowPrintSpaces
{
	display: block;
}

SPAN.PrintReminderHide
{
	visibility: hidden;
}

SPAN.PrintReminderShow
{
	visibility: visible;
	letter-spacing: 2px;
	background-color: #FFFFFF; 
	color: #navy; 
	font-size: 11px; 
	font-family: arial; 
	border-top: solid 1px navy; 
	border-bottom: solid 1px navy;
}
</style>
<script language="JavaScript">
function PerformPrint()
{
	if(document.all.PrintSpaces != null)
	{
		document.all.PrintSpaces.className = "ShowPrintSpaces";
	}
	window.print();
}

function ShowReminder(intAction)
{
	
	if(intAction == 1)
	{
		document.all.PrintReminder.className = "PrintReminderShow";
	}
	else
	{
		document.all.PrintReminder.className = "PrintReminderHide";
	}
}
</script>
</head>

<body>

<cfif #form.sm_type# EQ "SPKR">
	<cfset ModSpeakerID = #form.speakers#>
	<cfset Table_Col = "speaker_id">
<cfelseif #form.sm_type# EQ "MOD">
	<cfset ModSpeakerID = #form.moderators#>
	<cfset Table_Col = "staff_id">
<cfelse>
	<cfinclude template="error_handler.cfm">
	<cfabort>
</cfif>

<cfscript>
	//Instantiate the objects outside of the loop
	oCivTime = createObject('component','pms.com.cfc_time_conversion');
</cfscript>

<CFQUERY DATASOURCE="#application.SpeakerDSN#" NAME='getSpeakerModName'>
	SELECT firstname, lastname, speaker_id
	FROM spkr_table
	WHERE speaker_id = #ModSpeakerID#
	ORDER BY lastname
</CFQUERY>

<cfoutput>
	<center>
		<div style="font-size: 16px; font-family: arial; font-weight: bold; padding-bottom: 7px; color: navy; border-bottom: solid 1px navy;" width="100%">
			#getSpeakerModName.firstname# #getSpeakerModName.lastname# - <cfif #form.report_type# EQ "meeting">Meeting Schedule<cfelseif #form.report_type# EQ "unavailable">Unavailable Calendar</cfif>
		</div>
	</center>
</cfoutput>

<cfoutput>
	<div style="font-size: 14px; padding-top: 15px;"><center><strong>#MonthAsString(form.select_month)# #form.select_year#</strong></center></div>
</cfoutput>

<cfif #form.report_type# EQ "meeting">
	
	<TABLE ALIGN="Center" WIDTH="99%" BORDER="1px" bordercolor="#336699">
		<TR CLASS="Days" ALIGN="Center" HEIGHT="15">
			<TD WIDTH="106">Sun.</TD>
			<TD WIDTH="106">Mon.</TD>
			<TD WIDTH="106">Tues.</TD>
			<TD WIDTH="106">Wed.</TD>
			<TD WIDTH="106">Thu.</TD>
			<TD WIDTH="106">Fri.</TD>
			<TD WIDTH="106">Sat.</TD>
		</TR>
	<!--- Starting Day of Month ---->
	<CFSET StartDay = DayOfWeek(CreateDate(form.select_year, form.select_month, 1))>
		
	<!--- Days in Month --->
	<CFSET DaysMonth = DaysInMonth(CreateDate(form.select_year, form.select_month, 1))>
		
	<CFSET DayNumbers = 1>
	<CFSET Counter = 1>
		
	<TR HEIGHT="85">
	<CFLOOP CONDITION = "DayNumbers EQ 1">
	
	<CFQUERY DATASOURCE="#application.projdsn#" NAME="GetMeetings">
		SELECT *
		FROM schedule_meeting_time
		WHERE #Table_Col# = #ModSpeakerID# 
		AND year = #form.select_year# 
		AND month = #form.select_month# 
		AND day = #DayNumbers#
		AND status = 0
	</CFQUERY>
	
		<!--- ****** Set the color and funtionality of the square for the day. If
		square is part of last month, make it uneditable and gray  --->
		<CFIF StartDay EQ Counter>		
			
      <TD WIDTH="106" STYLE="background-color: FFFFFF; color: 000000; font-size: 10px; position: relative; padding-top: 12px"> 
        <cfif #GetMeetings.recordcount#>
          <cfoutput query="GetMeetings"> 
            <cfscript>
						CivilianTime = oCivTime.toCivilian(BeginMilitary='#GetMeetings.start_time#',EndMilitary='#GetMeetings.end_time#');
					</cfscript>
            <center>
              <span class="CalInfoSpan">#GetMeetings.project_code# - #CivilianTime[1]#:#CivilianTime[2]##CivilianTime[3]#</span> 
            </center>
          </cfoutput><br>
        </cfif> <cfelse> 
      <TD WIDTH="106" STYLE="background-color: FFFFFF; color: 000000; font-size: 10px; position: relative;"> </cfif>	
        <CFIF StartDay EQ Counter>
          <CFOUTPUT> <span style="position: absolute; top: 1; left: 2;"> 
            <center>
              #DayNumbers# 
            </center>
            </span> </CFOUTPUT> 
          <CFSET DayNumbers = 2>
          <CFELSE>
          &nbsp; </CFIF> &nbsp; </TD>
		<CFSET Counter = Counter + 1>
	</CFLOOP>
		
	<CFLOOP CONDITION = "(DayNumbers LTE DaysMonth) OR  ((DayNumbers GT DaysMonth) AND ((Counter MOD 7) NEQ 1))">
	
	<CFQUERY DATASOURCE="#application.projdsn#" NAME="GetMeetings">
		SELECT *
		FROM schedule_meeting_time
		WHERE #Table_Col# = #ModSpeakerID# 
		AND year = #form.select_year# 
		AND month = #form.select_month# 
		AND day = #DayNumbers#
		AND status = 0
	</CFQUERY>
	
	<CFIF DayNumbers LTE DaysMonth>	<!--- Create rows of boxes with the date numbers in them --->
		<CFIF (Counter MOD 7) EQ 1>	<!--- Start a new row --->
			</TR>
			<TR HEIGHT="85">
				
    <TD WIDTH="106" STYLE="background-color: FFFFFF; color: 000000; font-size: 10px; position: relative; padding-top: 12px"> 
      <cfif #GetMeetings.recordcount#>
        <cfoutput query="GetMeetings"> 
          <cfscript>
		  	CivilianTime = oCivTime.toCivilian(BeginMilitary='#GetMeetings.start_time#',EndMilitary='#GetMeetings.end_time#');
		  </cfscript>
          <center>
            <span class="CalInfoSpan">#GetMeetings.project_code# - #CivilianTime[1]#:#CivilianTime[2]##CivilianTime[3]#</span> 
          </center>
        </cfoutput> <br>
      </cfif> <span style="position: absolute; top: 1; left: 2;"><CFOUTPUT> 
        <center>
          #DayNumbers# 
        </center>
      </CFOUTPUT></span> &nbsp; </TD>
		<CFELSE>	<!--- Finish current row --->
			
    <TD WIDTH="106" STYLE="background-color: FFFFFF; color: 000000; font-size: 10px; position: relative; padding-top: 12px"> 
      <cfif #GetMeetings.recordcount#>
        <cfoutput query="GetMeetings"> 
          <cfscript>
			CivilianTime = oCivTime.toCivilian(BeginMilitary='#GetMeetings.start_time#',EndMilitary='#GetMeetings.end_time#');
		  </cfscript>
          <center>
            <span class="CalInfoSpan">#GetMeetings.project_code# - #CivilianTime[1]#:#CivilianTime[2]##CivilianTime[3]#</span> 
          </center>
        </cfoutput> <br>
      </cfif> <span style="position: absolute; top: 1; left: 2;"><CFOUTPUT> 
        <center>
          #DayNumbers# 
        </center>
      </CFOUTPUT></span> &nbsp; </TD>
		</CFIF>
		
	<CFELSEIF (DayNumbers GT DaysMonth) AND ((Counter MOD 7) NEQ 1)>	<!--- Complete current row of boxes before quitting --->
		<TD WIDTH="106" STYLE="background-color: FFFFFF; color: 000000; font-size: 10px;">&nbsp;</TD>
	</CFIF>	<!--- Quit on a complete row of boxes --->
	
	<!--- Increment the counter and the day numberer variables --->
	<CFSET DayNumbers = DayNumbers + 1>
	<CFSET Counter = Counter + 1>
	
	</CFLOOP>
	
	</TABLE>
	
	
	<cfset oBeginDate = #CreateDate(form.select_year, form.select_month, 1)#>
	<cfset iDaysInMonth = #DaysInMonth(oBeginDate)#>
	<cfset oEndDate = #CreateDate(form.select_year, form.select_month, iDaysInMonth)#>
	
	<!----Display all meetings Speaker will act as additional speaker----->
	<cfif #form.sm_type# EQ "SPKR">
		
		<CFQUERY DATASOURCE="#application.projdsn#" NAME="getAdditionalMeetings">
			SELECT meeting_rowid
			FROM additional_speakers
			WHERE spkrid = #trim(ModSpeakerID)#
			AND (add_meeting_date BETWEEN #oBeginDate# AND #oEndDate#)
		</CFQUERY>
		
		<p>&nbsp;</p>
		<table width="600" border="0" align="center" cellpadding="5" cellspacing="0">
			<TR> 
				<TD colspan="3" CLASS="tdheader"><strong>Scheduled as Additional Speaker</strong></TD>
			</TR>
			<tr>
				<td style="border-left: solid 1px #336699; border-top: solid 1px #336699;" width="200"><strong>Project</strong></td>
				<td style="border-left: solid 1px #336699; border-top: solid 1px #336699;" width="200"><strong>Date</strong></td>
				<td style="border-left: solid 1px #336699; border-right: solid 1px #336699; border-top: solid 1px #6699FF;" width="200"><strong>Time</strong></td>
			</tr>
			<cfif #getAdditionalMeetings.recordcount#>
				<cfoutput query="getAdditionalMeetings">
					<CFQUERY DATASOURCE="#application.projdsn#" NAME="getProjectCode">
						SELECT project_code, meeting_date, start_time, end_time
						FROM schedule_meeting_time 
						WHERE rowid = #getAdditionalMeetings.meeting_rowid# 
					</CFQUERY> 
					<cfscript>
						CivilianTime = oCivTime.toCivilian(BeginMilitary='#getProjectCode.start_time#',EndMilitary='#getProjectCode.end_time#');
					</cfscript>
					<tr>
						<td style="border-left: solid 1px ##336699; border-top: solid 1px ##336699;" width="200">#getProjectCode.project_code#</td>
						<td style="border-left: solid 1px ##336699; border-top: solid 1px ##336699;" width="200">#DateFormat(getProjectCode.meeting_date, "m/d/yyyy")#</td>
						<td style="border-left: solid 1px ##336699; border-right: solid 1px ##336699; border-top: solid 1px ##336699;" width="200">#CivilianTime[1]#:#CivilianTime[2]##CivilianTime[3]#</td>
					</tr>
				</cfoutput>
			<cfelse>
				<tr>
					<td colspan="3" style="border-left: solid 1px #336699; border-right: solid 1px #336699; border-top: solid 1px #336699;">Not scheduled as an additional speaker for any meetings during this time period.</td>
				</tr>
			</cfif>
			<tr>
				<td colspan="3" style="border-top: solid 1px #336699;">&nbsp;</td>
			</tr>
		</table>
	</cfif>
	
	<!-------------This will pull Listen In Schedule------------>
	<CFQUERY DATASOURCE="#application.projdsn#" NAME="getListenIns">
		SELECT meeting_rowid
		FROM listen_ins
		WHERE modspkrid = #trim(ModSpeakerID)#
		AND (add_meeting_date BETWEEN #oBeginDate# AND #oEndDate#)
	</CFQUERY>
	
	<p>&nbsp;</p>
	<table width="600" border="0" align="center" cellpadding="5" cellspacing="0">
		<TR> 
			<TD colspan="3" CLASS="tdheader"><strong>Scheduled as Listen In</strong></TD>
		</TR>
		<tr>
			<td style="border-left: solid 1px #336699; border-top: solid 1px #336699;" width="200"><strong>Project</strong></td>
			<td style="border-left: solid 1px #336699; border-top: solid 1px #336699;" width="200"><strong>Date</strong></td>
			<td style="border-left: solid 1px #336699; border-right: solid 1px #336699; border-top: solid 1px #336699;" width="200"><strong>Time</strong></td>
		</tr>
		<cfif #getListenIns.recordcount#>
			<cfoutput query="getListenIns">
				<CFQUERY DATASOURCE="#application.projdsn#" NAME="getProjectCode">
					SELECT project_code, meeting_date, start_time, end_time
					FROM schedule_meeting_time 
					WHERE rowid = #getListenIns.meeting_rowid# 
				</CFQUERY> 
				<cfscript>
					CivilianTime = oCivTime.toCivilian(BeginMilitary='#getProjectCode.start_time#',EndMilitary='#getProjectCode.end_time#');
				</cfscript>
				<tr>
					<td style="border-left: solid 1px ##336699; border-top: solid 1px ##336699;" width="200">#getProjectCode.project_code#</td>
					<td style="border-left: solid 1px ##336699; border-top: solid 1px ##336699;" width="200">#DateFormat(getProjectCode.meeting_date, "m/d/yyyy")#</td>
					<td style="border-left: solid 1px ##336699; border-right: solid 1px ##336699; border-top: solid 1px ##336699;" width="200">#CivilianTime[1]#:#CivilianTime[2]##CivilianTime[3]#</td>
				</tr>
			</cfoutput>
		<cfelse>
			<tr>
				<td colspan="3" style="border-left: solid 1px #336699; border-right: solid 1px #336699; border-top: solid 1px #336699;">Not scheduled as a listen in for any meetings during this time period.</td>
			</tr>
		</cfif>
		<tr>
			<td colspan="3" style="border-top: solid 1px #336699;">&nbsp;</td>
		</tr>
	</table>
	<!----------------End Listen-In Table------------------>
	
	<!-------------This will pull Training Schedule------------>
	<CFQUERY DATASOURCE="#application.projdsn#" NAME="getTrainees">
		SELECT meeting_rowid
		FROM training
		WHERE modspkrid = #trim(ModSpeakerID)#
		AND (add_meeting_date BETWEEN #oBeginDate# AND #oEndDate#)
	</CFQUERY>
	
	<p>&nbsp;</p>
	<table width="600" border="0" align="center" cellpadding="5" cellspacing="0">
		<TR> 
			<TD colspan="3" CLASS="tdheader"><strong>Scheduled as Trainee</strong></TD>
		</TR>
		<tr>
			<td style="border-left: solid 1px #336699; border-top: solid 1px #336699;" width="200"><strong>Project</strong></td>
			<td style="border-left: solid 1px #336699; border-top: solid 1px #336699;" width="200"><strong>Date</strong></td>
			<td style="border-left: solid 1px #336699; border-right: solid 1px #336699; border-top: solid 1px #336699;" width="200"><strong>Time</strong></td>
		</tr>
		<cfif #getTrainees.recordcount#>
			<cfoutput query="getTrainees">
				<CFQUERY DATASOURCE="#application.projdsn#" NAME="getProjectCode">
					SELECT project_code, meeting_date, start_time, end_time
					FROM schedule_meeting_time 
					WHERE rowid = #getTrainees.meeting_rowid# 
				</CFQUERY> 
				<cfscript>
					CivilianTime = oCivTime.toCivilian(BeginMilitary='#getProjectCode.start_time#',EndMilitary='#getProjectCode.end_time#');
				</cfscript>
				<tr>
					<td style="border-left: solid 1px ##336699; border-top: solid 1px ##336699;" width="200">#getProjectCode.project_code#</td>
					<td style="border-left: solid 1px ##336699; border-top: solid 1px ##336699;" width="200">#DateFormat(getProjectCode.meeting_date, "m/d/yyyy")#</td>
					<td style="border-left: solid 1px ##336699; border-right: solid 1px ##336699; border-top: solid 1px ##336699;" width="200">#CivilianTime[1]#:#CivilianTime[2]##CivilianTime[3]#</td>
				</tr>
			</cfoutput>
		<cfelse>
			<tr>
				<td colspan="3" style="border-left: solid 1px #336699; border-right: solid 1px #336699; border-top: solid 1px #336699;">Not scheduled as a trainee for any meetings during this time period.</td>
			</tr>
		</cfif>
		<tr>
			<td colspan="3" style="border-top: solid 1px #336699;">&nbsp;</td>
		</tr>
	</table>
	<!----------------End Training Table------------------>
	
	
<cfelseif #form.report_type# EQ "unavailable">

	<TABLE ALIGN="Center" WIDTH="742px" BORDER="1px" bordercolor="#336699">
		<TR CLASS="Days" ALIGN="Center" HEIGHT="15">
			<TD WIDTH="106">Sun.</TD>
			<TD WIDTH="106">Mon.</TD>
			<TD WIDTH="106">Tues.</TD>
			<TD WIDTH="106">Wed.</TD>
			<TD WIDTH="106">Thu.</TD>
			<TD WIDTH="106">Fri.</TD>
			<TD WIDTH="106">Sat.</TD>
		</TR>
	<!--- Starting Day of Month ---->
	<CFSET StartDay = DayOfWeek(CreateDate(form.select_year, form.select_month, 1))>
		
	<!--- Days in Month --->
	<CFSET DaysMonth = DaysInMonth(CreateDate(form.select_year, form.select_month, 1))>
		
	<CFSET DayNumbers = 1>
	<CFSET Counter = 1>
		
	<TR HEIGHT="85">
	<CFLOOP CONDITION = "DayNumbers EQ 1">
	
	<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="getunavailable">
		SELECT *
		FROM availability_time
		WHERE owner_id = #ModSpeakerID# 
		AND (allday = 0 or allday = 2) 
		AND month = #form.select_month# 
		AND year = #form.select_year# 
		AND day = #DayNumbers#
		ORDER BY year, Month, Day
	</CFQUERY> 
	
		<!--- ****** Set the color and funtionality of the square for the day. If
		square is part of last month, make it uneditable and gray  --->
		<CFIF StartDay EQ Counter>		
			
      <TD WIDTH="106" STYLE="background-color: FFFFFF; color: 000000; font-size: 10px; position: relative; padding-top: 12px"> 
        <cfif #getunavailable.recordcount#>
          <cfinclude template="report_modspkr_calendar_inc.cfm">
        </cfif> <cfelse> 
      <TD WIDTH="106" STYLE="background-color: FFFFFF; color: 000000; font-size: 10px; position: relative;"> </cfif>	
        <CFIF StartDay EQ Counter>
          <CFOUTPUT> <span style="position: absolute; top: 1; left: 2;"> 
            <center>
              #DayNumbers# 
            </center>
            </span> </CFOUTPUT> 
          <CFSET DayNumbers = 2>
          <CFELSE>
          &nbsp; </CFIF> &nbsp; </TD>
		<CFSET Counter = Counter + 1>
	</CFLOOP>
		
	<CFLOOP CONDITION = "(DayNumbers LTE DaysMonth) OR  ((DayNumbers GT DaysMonth) AND ((Counter MOD 7) NEQ 1))">
	
	<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="getunavailable">
		SELECT *
		FROM availability_time
		WHERE owner_id = #ModSpeakerID# 
		AND (allday = 0 or allday = 2) 
		AND month = #form.select_month# 
		AND year = #form.select_year# 
		AND day = #DayNumbers#
		ORDER BY year, Month, Day
	</CFQUERY> 
	
	<CFIF DayNumbers LTE DaysMonth>	<!--- Create rows of boxes with the date numbers in them --->
		<CFIF (Counter MOD 7) EQ 1>	<!--- Start a new row --->
			</TR>
			<TR HEIGHT="85">
				
    <TD WIDTH="106" STYLE="background-color: FFFFFF; color: 000000; font-size: 10px; position: relative; padding-top: 12px"> 
      <cfif #getunavailable.recordcount#>
        <cfoutput query="getunavailable"> 
          <cfinclude template="report_modspkr_calendar_inc.cfm">
        </cfoutput> <br>
      </cfif> <span style="position: absolute; top: 1; left: 2;"><CFOUTPUT> 
        <center>
          #DayNumbers# 
        </center>
      </CFOUTPUT></span> &nbsp; </TD>
		<CFELSE>	<!--- Finish current row --->
			
    <TD WIDTH="106" STYLE="background-color: FFFFFF; color: 000000; font-size: 10px; position: relative; padding-top: 12px"> 
      <cfif #getunavailable.recordcount#>
        <cfoutput query="getunavailable"> 
          <cfinclude template="report_modspkr_calendar_inc.cfm">
        </cfoutput> <br>
      </cfif> <span style="position: absolute; top: 1; left: 2;"><CFOUTPUT> 
        <center>
          #DayNumbers# 
        </center>
      </CFOUTPUT></span> &nbsp; </TD>
		</CFIF>
		
	<CFELSEIF (DayNumbers GT DaysMonth) AND ((Counter MOD 7) NEQ 1)>	<!--- Complete current row of boxes before quitting --->
		<TD WIDTH="106" STYLE="background-color: FFFFFF; color: 000000; font-size: 10px;">&nbsp;</TD>
	</CFIF>	<!--- Quit on a complete row of boxes --->
	
	<!--- Increment the counter and the day numberer variables --->
	<CFSET DayNumbers = DayNumbers + 1>
	<CFSET Counter = Counter + 1>
	
	</CFLOOP>
	
	</TABLE>
	
	<div class="HidePrintSpaces" id="PrintSpaces"><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><br><br></div>
	
	<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="getunavailable">
		SELECT *
		FROM availability_time
		WHERE owner_id = #ModSpeakerID# 
		AND (allday = 0 OR allday = 2) 
		AND month = #form.select_month# 
		AND year = #form.select_year# 
		ORDER BY year, Month, Day
	</CFQUERY>
	<p>&nbsp;</p>
	<table width="600" border="0" align="center" cellpadding="5" cellspacing="0">
		<TR> 
			<TD colspan="3" CLASS="tdheader"><strong>Unavailability Report Detail - <cfoutput>#getSpeakerModName.firstname# #getSpeakerModName.lastname#</cfoutput></strong></TD>
		</TR>
		<tr>
			<td style="border-left: solid 1px #336699; border-top: solid 1px #336699;" width="50"><strong>Day</strong></td>
			<td style="border-left: solid 1px #336699; border-top: solid 1px #336699;" width="150"><strong>Unavailable Times</strong></td>
			<td style="border-left: solid 1px #336699; border-right: solid 1px #336699; border-top: solid 1px #336699;" width="400"><strong>Comments</strong></td>
		</tr>
		<cfoutput query="getunavailable">
		<cfset udate = CreateDate(#getunavailable.year#, #getunavailable.month#, #getunavailable.day#)>
		<cfif #DayOfWeek(udate)# NEQ 1 AND #DayOfWeek(udate)# NEQ 6 AND #DayOfWeek(udate)# NEQ 7>
		<tr>
			<td style="border-left: solid 1px ##336699; border-top: solid 1px ##336699;">#month#/#day#/#year#</td>
			<td style="border-left: solid 1px ##336699; border-top: solid 1px ##336699;">
				<cfif getunavailable.allday EQ 0>All Day
				<cfelse>
					<cfif getunavailable.x0500 EQ 0>5:00AM</cfif>
					<cfif getunavailable.x0550 EQ 0>5:30AM</cfif>
					<cfif getunavailable.x0600 EQ 0>6:00AM</cfif>
					<cfif getunavailable.x0650 EQ 0>6:30AM</cfif>
					<cfif getunavailable.x0700 EQ 0>7:00AM</cfif>
					<cfif getunavailable.x0750 EQ 0>7:30AM</cfif>
					<cfif getunavailable.x0800 EQ 0>8:00AM</cfif>
					<cfif getunavailable.x0850 EQ 0>8:30AM</cfif>
					<cfif getunavailable.x0900 EQ 0>9:00AM</cfif>
					<cfif getunavailable.x0950 EQ 0>9:30AM</cfif>
					<cfif getunavailable.x1000 EQ 0>10:00AM</cfif>
					<cfif getunavailable.x1050 EQ 0>10:30AM</cfif>	
					<cfif getunavailable.x1100 EQ 0>11:00AM</cfif>
					<cfif getunavailable.x1150 EQ 0>11:30AM</cfif>
					<cfif getunavailable.x1200 EQ 0>12:00PM</cfif>
					<cfif getunavailable.x1250 EQ 0>12:30PM</cfif>
					<cfif getunavailable.x1300 EQ 0>1:00PM</cfif>
					<cfif getunavailable.x1350 EQ 0>1:30PM</cfif>
					<cfif getunavailable.x1400 EQ 0>2:00PM</cfif>
					<cfif getunavailable.x1450 EQ 0>2:30PM</cfif>
					<cfif getunavailable.x1500 EQ 0>3:00PM</cfif>
					<cfif getunavailable.x1550 EQ 0>3:30PM</cfif>
					<cfif getunavailable.x1600 EQ 0>4:00PM</cfif>
					<cfif getunavailable.x1650 EQ 0>4:30PM</cfif>
					<cfif getunavailable.x1700 EQ 0>5:00PM</cfif>
					<cfif getunavailable.x1750 EQ 0>5:30PM</cfif>
					<cfif getunavailable.x1800 EQ 0>6:00PM</cfif>
					<cfif getunavailable.x1850 EQ 0>6:30PM</cfif>
					<cfif getunavailable.x1900 EQ 0>7:00PM</cfif>
					<cfif getunavailable.x1950 EQ 0>7:30PM</cfif>
					<cfif getunavailable.x2000 EQ 0>8:00PM</cfif>
					<cfif getunavailable.x2050 EQ 0>8:30PM</cfif>
					<cfif getunavailable.x2100 EQ 0>9:00PM</cfif>
					<cfif getunavailable.x2150 EQ 0>9:30PM</cfif>
					<cfif getunavailable.x2200 EQ 0>10:00PM</cfif>
					<cfif getunavailable.x2250 EQ 0>10:30PM</cfif>
					<cfif getunavailable.x2300 EQ 0>11:00PM</cfif>
					<cfif getunavailable.x2350 EQ 0>11:30PM</cfif>
					<cfif getunavailable.x2400 EQ 0>12:00PM</cfif>
				</cfif>
			</td>
			<td style="border-left: solid 1px ##336699; border-right: solid 1px ##336699; border-top: solid 1px ##336699;">
			<cfif getunavailable.comments EQ "">&nbsp;<cfelse>#comments#</cfif></td>
		</tr>
			</cfif>
		</cfoutput>
		<tr><td colspan="3" style="border-top: solid 1px #6699FF;">&nbsp;</td></tr>	
	</table>

</cfif>
<p><center><input type="button"  value=" Print Calendar " onclick="PerformPrint()" onmouseover="ShowReminder(1)" onmouseout="ShowReminder(2)"> &nbsp; &nbsp; &nbsp; &nbsp; <input type="button"  value=" Go Back " onclick="document.location.href='report_modspkr_calendar.cfm'"></center></p>
<center><span class="PrintReminderHide" id="PrintReminder">Change page layout to landscape before printing</span></center>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
