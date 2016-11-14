<!------------------
report_TBD2.cfm

Shows speaker and moderator TBDs for a period of time and/or by project

----------------------->

<cfif NOT isDefined("URL.report")>
	<cfinclude template="error_handler.cfm">
	<cfabort>
</cfif>

<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="TBD Report" showCalendar="0">

<cfset BeginingDate = CreateDate(Year(form.begin_date), Month(form.begin_date), Day(form.begin_date))>
<cfset EndingDate = CreateDate(Year(form.end_date), Month(form.end_date), Day(form.end_date))>


	<CFQUERY DATASOURCE="#application.projdsn#" NAME="GetTBD">
		SELECT m.project_code, m.start_time, m.meeting_date, m.staff_id, s.staff_description
		FROM PMSProd.dbo.schedule_meeting_time m, PMSProd.dbo.staff_codes s
		WHERE (m.meeting_date BETWEEN #BeginingDate# AND #EndingDate#)
		AND m.status = 0 AND m.staff_type = s.staff_type
		AND m.staff_id = 0
		<cfif #form.rType# EQ "Mod">AND m.staff_type = 1
		<cfelseif #form.rType# EQ "Spkr">AND m.staff_type = 2
		<cfelse>AND (m.staff_type = 1 OR m.staff_type = 2)
		</cfif>
		<cfif #form.projcode# NEQ 0>AND m.project_code = '#form.projcode#'</cfif> 
		ORDER BY m.meeting_code, m.staff_type, m.staff_id					
	</CFQUERY>


</head>

<body>
<p>&nbsp;</p>
<cfif getTBD.recordcount>
	<cfif #URL.report# EQ "EXCEL">
		
		<cfset OutputArray = ArrayNew(1)>
		<cfset count = 1>
		
		<cfset OutputArray[count] = "<html><head></head><body><TABLE BORDER='1' CELLSPACING='0' CELLPADDING='0'><TR><TD colspan='4' style='padding-top: 2px; padding-bottom: 12px; font-size: 15px; text-align: center;'><strong>Scheduled TBDs <cfoutput>#DateFormat(BeginingDate,'m/dd/yyyy')# - #DateFormat(EndingDate,'m/dd/yyyy')#</cfoutput></strong></TD></TR><TR>">
		<cfset count = #count# + 1>
		
		<cfset OutputArray[count] = "<TD style='background-color: ##eeeeee;'><strong>Meeting Code</strong></TD><TD style='background-color: ##eeeeee;'><strong>Meeting Date</strong></TD><TD style='background-color: ##eeeeee;'><strong>Meeting Time</strong></TD><TD style='background-color: ##eeeeee;'><strong>TBD Staff Type</strong></TD></TR>">
		<cfset count = #count# + 1>
		
		
		<cfoutput query="getTBD">
			<!--- Set the starting time minutes --->
				<cfif Mid(getTBD.start_time, 3, 2) EQ 50>
					<cfset start_min = 30>
				<cfelse>
					<cfset start_min = Mid(getTBD.start_time, 3, 2)>
				</cfif>
		
				<!--- Convert meeting start time to Civilian Time --->
				<cfset TimeCreated = CreateTime(Left(getTBD.start_time, 2),start_min,00)>
				<cfset CivilianTime = TimeFormat(TimeCreated,'h:mmtt')>
						
			<cfset OutputArray[count] = "<TR><TD>#getTBD.project_code#</TD><TD>#DateFormat(getTBD.meeting_date, 'mm/dd/yyyy')#</TD><TD>#CivilianTime#</TD><TD>#getTBD.staff_description#</TD></TR>">
			<cfset count = #count# + 1>
			
		</cfoutput>
				
		<cfset OutputArray[count] = "</table></body></html>">
		
		<!--- <cfset #report_path# = "E:\INETPUB\WWWROOT\projects\cgi-bin\temp\rpt_temp.htm"> --->
		<cfset temp = #ArrayToList(OutputArray, " ")#>
		<cffile action="write" file="#application.ReportPath#/rpt_temp.htm" nameconflict="overwrite" output="#temp#">
		<cfcontent type="application/vnd.ms-excel" deletefile="NO" file="#application.ReportPath#/rpt_temp.htm">
		
	<cfelse><!---HTML Report has been requested----->
	
		<TABLE ALIGN="Center" BORDER="0" WIDTH="700px" CELLSPACING="0" CELLPADDING="0" style="border: solid 1px navy;">
			<TR>
				<TD colspan="4" style="padding-top: 2px; padding-bottom: 12px; font-size: 15px; text-align: center;"><strong>Scheduled TBDs <cfoutput>#DateFormat(BeginingDate,"m/dd/yyyy")# - #DateFormat(EndingDate,"m/dd/yyyy")#</cfoutput></strong></TD>
			</TR>
			<TR>
				<TD style="border-bottom: solid 2px navy; padding-top: 2px; padding-bottom: 2px; padding-left: 10px;"><strong>Meeting Code</strong></TD>
				<TD style="border-bottom: solid 2px navy; padding-top: 2px; padding-bottom: 2px;"><strong>Meeting Date</strong></TD>
				<TD style="border-bottom: solid 2px navy; padding-top: 2px; padding-bottom: 2px;"><strong>Meeting Time</strong></TD>
				<TD style="border-bottom: solid 2px navy; padding-top: 2px; padding-bottom: 2px;"><strong>TBD Staff Type</strong></TD>
			</TR>
			
			
			<cfoutput query="getTBD">
				
				<!--- Set the starting time minutes --->
				<cfif Mid(getTBD.start_time, 3, 2) EQ 50>
					<cfset start_min = 30>
				<cfelse>
					<cfset start_min = Mid(getTBD.start_time, 3, 2)>
				</cfif>
		
				<!--- Convert meeting start time to Civilian Time --->
				<cfset TimeCreated = CreateTime(Left(getTBD.start_time, 2),start_min,00)>
				<cfset CivilianTime = TimeFormat(TimeCreated,'h:mmtt')>
				<TR>
					<TD style="border-bottom: solid 1px navy; padding-top: 2px; padding-bottom: 2px; padding-left: 10px;">#getTBD.project_code#</TD>
					<TD style="border-bottom: solid 1px navy; padding-top: 2px; padding-bottom: 2px;">#DateFormat(getTBD.meeting_date, "mm/dd/yyyy")#</TD>
					<TD style="border-bottom: solid 1px navy; padding-top: 2px; padding-bottom: 2px;">#CivilianTime#</TD>
					<TD style="border-bottom: solid 1px navy; padding-top: 2px; padding-bottom: 2px;">#getTBD.staff_description#</TD>
				</TR>
			</cfoutput>
		</table>
	</cfif>
<cfelse>
&nbsp; &nbsp; <strong>No matching records were found.</strong>
</cfif>
<br><br>
<center><input type="button" value=" Go Back " onclick="document.location.href='report_TBD.cfm'"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <input type="button" value=" Print " onclick="javascript: window.print();"></center>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">

