<!------------------
report_listen_ins2.cfm

Shows listen ins for a period of time and/or by project

----------------------->

<cfif NOT isDefined("URL.report")>
	<cfinclude template="error_handler.cfm">
	<cfabort>
</cfif>
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Listen In Report" showCalendar="0">


<cfset BeginingDate = CreateDate(Year(form.begin_date), Month(form.begin_date), Day(form.begin_date))>
<cfset EndingDate = CreateDate(Year(form.end_date), Month(form.end_date), Day(form.end_date))>


	<CFQUERY DATASOURCE="#application.projdsn#" NAME="GetListen">
		SELECT m.project_code, m.start_time, m.meeting_date, s.staff_description, 
				sp.lastname, sp.firstname, sc.fee
		FROM projman.dbo.ScheduleSpeaker m, projman.dbo.staff_codes s, speaker.dbo.Speaker sp, speaker.dbo.speaker_clients sc
		WHERE (m.meeting_date BETWEEN #BeginingDate# AND #EndingDate#)
		AND m.status = 0 AND m.staff_type = s.staff_type AND m.staff_id = sp.speakerid AND m.client_rowid = sc.rowid
		<cfif #form.rType# EQ "Mod">AND m.staff_type = 3
		<cfelseif #form.rType# EQ "Spkr">AND m.staff_type = 6
		<cfelse>AND (m.staff_type = 3 OR m.staff_type = 6)
		</cfif>
		<cfif #form.projcode# NEQ 0>AND m.project_code = '#form.projcode#'</cfif> 
		ORDER BY m.meeting_code, m.staff_type, m.staff_id					
	</CFQUERY>


</head>

<body>
<p>&nbsp;</p>
<cfif getListen.recordcount>
	<cfif #URL.report# EQ "EXCEL">
		
		<cfset OutputArray = ArrayNew(1)>
		<cfset count = 1>
		
		<cfset OutputArray[count] = "<html><head></head><body><TABLE BORDER='1' CELLSPACING='0' CELLPADDING='0'><TR>">
		<cfset count = #count# + 1>
		
		<cfset OutputArray[count] = "<TD><strong>Project Code</strong></TD><TD><strong>Meeting Date</strong></TD><TD><strong>Meeting Time</strong></TD><TD><strong>Listener First Name</strong></TD><TD><strong>Listener Last Name</strong></TD><TD><strong>Listener Type</strong></TD><TD><strong>Honoraria</strong></TD></TR>">
		<cfset count = #count# + 1>

		
		<cfoutput query="getListen">
				<!--- Set the starting time minutes --->
				<cfif Mid(GetListen.start_time, 3, 2) EQ 50>
					<cfset start_min = 30>
				<cfelse>
					<cfset start_min = Mid(GetListen.start_time, 3, 2)>
				</cfif>
		
				<!--- Convert meeting start time to Civilian Time --->
				<cfset TimeCreated = CreateTime(Left(GetListen.start_time, 2),start_min,00)>
				<cfset CivilianTime = TimeFormat(TimeCreated,'h:mmtt')>
			
			<cfset OutputArray[count] = "<TR><TD>#getListen.project_code#</TD><TD>#DateFormat(getListen.meeting_date, 'mm/dd/yyyy')#</TD><TD>#CivilianTime#</TD><TD>#getListen.firstname#</TD><TD>#getListen.lastname#</TD><TD>#getListen.staff_description#</TD><TD>#DollarFormat(getListen.fee)#</TD></TR>">
			<cfset count = #count# + 1>
		</cfoutput>
		
		<cfset OutputArray[count] = "</table>">
		<cfset count = #count# + 1>
		
		<!--- <cfset #report_path# = "E:\INETPUB\WWWROOT\projects\cgi-bin\temp\rpt_temp.htm"> --->
		<cfset temp = #ArrayToList(OutputArray, " ")#>
		<cffile action="write" file="#application.ReportPath#/rpt_temp.htm" nameconflict="overwrite" output="#temp#">
		<cfcontent type="application/vnd.ms-excel" deletefile="NO" file="#application.ReportPath#/rpt_temp.htm">
		
	<cfelse><!---HTML Report has been requested----->
	
		<TABLE ALIGN="Center" BORDER="0" WIDTH="700px" CELLSPACING="0" CELLPADDING="0" style="border: solid 1px navy;">
			<tr>
				<td height="40" align="center" colspan="5"><strong><font size="3">Listen Ins Report</font></strong></td>
			</tr>
			<TR>
				<TD style="border-bottom: solid 2px navy; padding-left: 5px; padding-top: 2px; padding-bottom: 2px;"><strong>Project Code</strong></TD>
				<TD style="border-bottom: solid 2px navy; padding-top: 2px; padding-bottom: 2px;"><strong>Meeting Date</strong></TD>
				<TD style="border-bottom: solid 2px navy; padding-top: 2px; padding-bottom: 2px;"><strong>Meeting Time</strong></TD>
				<TD style="border-bottom: solid 2px navy; padding-top: 2px; padding-bottom: 2px;"><strong>Listener</strong></TD>
				<TD style="border-bottom: solid 2px navy; padding-top: 2px; padding-bottom: 2px;"><strong>Honoraria</strong></TD>
			</TR>
			
			
			<cfoutput query="getListen">
				
				
				<!--- Set the starting time minutes --->
				<cfif Mid(GetListen.start_time, 3, 2) EQ 50>
					<cfset start_min = 30>
				<cfelse>
					<cfset start_min = Mid(GetListen.start_time, 3, 2)>
				</cfif>
		
				<!--- Convert meeting start time to Civilian Time --->
				<cfset TimeCreated = CreateTime(Left(GetListen.start_time, 2),start_min,00)>
				<cfset CivilianTime = TimeFormat(TimeCreated,'h:mmtt')>
				
				<TR>
					<TD style="border-bottom: solid 1px navy; padding-top: 2px; padding-left: 5px; padding-bottom: 2px;">#getListen.project_code#</TD>
					<TD style="border-bottom: solid 1px navy; padding-top: 2px; padding-bottom: 2px;">#DateFormat(getListen.meeting_date, "mm/dd/yyyy")#</TD>
					<TD style="border-bottom: solid 1px navy; padding-top: 2px; padding-bottom: 2px;">#CivilianTime#</TD>
					<TD style="border-bottom: solid 1px navy; padding-top: 2px; padding-bottom: 2px;">#trim(getListen.firstname)# #trim(getListen.lastname)# - #getListen.staff_description#</TD>
					<TD style="border-bottom: solid 1px navy; padding-top: 2px; padding-bottom: 2px;">#DollarFormat(getListen.fee)#</TD>
				</TR>
			</cfoutput>
		</table>
	</cfif>
<cfelse>
&nbsp; &nbsp; <strong>No matching records were found.</strong>
</cfif>
<br><br>
<center><input type="button"  value=" Go Back " onclick="document.location.href='report_listen_ins.cfm'"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <input type="button"  value=" Print " onclick="javascript: window.print();"></center>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">

