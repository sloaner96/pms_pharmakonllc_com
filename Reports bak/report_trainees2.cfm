<!------------------
report_trainees2.cfm

Shows trainees for a period of time and/or by project

----------------------->

<cfif NOT isDefined("URL.report")>
	<cfinclude template="error_handler.cfm">
	<cfabort>
</cfif>

<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Trainees Report" showCalendar="0">

<cfset BeginingDate = CreateDate(Year(form.begin_date), Month(form.begin_date), Day(form.begin_date))>
<cfset EndingDate = CreateDate(Year(form.end_date), Month(form.end_date), Day(form.end_date))>


	<CFQUERY DATASOURCE="#application.projdsn#" NAME="GetTrainees">
		SELECT m.project_code, m.start_time, m.meeting_date, s.staff_description, 
				sp.lastname, sp.firstname, sc.fee
		FROM PMSProd.dbo.schedule_meeting_time m, PMSProd.dbo.staff_codes s, speaker.dbo.spkr_table sp, speaker.dbo.speaker_clients sc
		WHERE (m.meeting_date BETWEEN #BeginingDate# AND #EndingDate#)
		AND m.status = 0 AND m.staff_type = s.staff_type AND m.staff_id = sp.speaker_id AND m.client_rowid = sc.rowid
		<cfif #form.rType# EQ "Mod">AND m.staff_type = 4
		<cfelseif #form.rType# EQ "Spkr">AND m.staff_type = 7
		<cfelse>AND (m.staff_type = 4 OR m.staff_type = 7)
		</cfif>
		<cfif #form.projcode# NEQ 0>AND m.project_code = '#form.projcode#'</cfif> 
		ORDER BY m.meeting_code, m.staff_type, m.staff_id					
	</CFQUERY>


</head>

<body>
<p>&nbsp;</p>
<cfif getTrainees.recordcount>
	<cfif #URL.report# EQ "EXCEL">
		
		<cfset OutputArray = ArrayNew(1)>
		<cfset count = 1>
		
		<cfset OutputArray[count] = "<html><head></head><body><TABLE BORDER='1' CELLSPACING='0' CELLPADDING='0'><TR><TD colspan='5' style='padding-top: 2px; padding-bottom: 12px; font-size: 15px; text-align: center;'><strong>Scheduled Trainees <cfoutput>#DateFormat(BeginingDate,'m/dd/yyyy')# - #DateFormat(EndingDate,'m/dd/yyyy')#</cfoutput></strong></TD></TR><TR>">
		<cfset count = #count# + 1>
		
		<cfset OutputArray[count] = "<TD style='background-color: ##CCCCCC;'><strong>Meeting Code</strong></TD><TD style='background-color: ##CCCCCC;'><strong>Meeting Date</strong></TD><TD style='background-color: ##CCCCCC;'><strong>Meeting Time</strong></TD><TD style='background-color: ##CCCCCC;'><strong>Trainee First Name</strong></TD><TD style='background-color: ##CCCCCC;'><strong>Trainee Last Name</strong></TD><TD style='background-color: ##CCCCCC;'><strong>Trainee Description</strong></TD><TD style='background-color: ##CCCCCC;'><strong>Honoraria</strong></TD></TR>">
		<cfset count = #count# + 1>
		
		<cfset TotalHonoraria = 0>
		
		<cfoutput query="getTrainees">
			<!--- Set the starting time minutes --->
				<cfif Mid(GetTrainees.start_time, 3, 2) EQ 50>
					<cfset start_min = 30>
				<cfelse>
					<cfset start_min = Mid(GetTrainees.start_time, 3, 2)>
				</cfif>
		
				<!--- Convert meeting start time to Civilian Time --->
				<cfset TimeCreated = CreateTime(Left(GetTrainees.start_time, 2),start_min,00)>
				<cfset CivilianTime = TimeFormat(TimeCreated,'h:mmtt')>
						
			<cfset OutputArray[count] = "<TR><TD>#getTrainees.project_code#</TD><TD>#DateFormat(getTrainees.meeting_date, 'mm/dd/yyyy')#</TD><TD>#CivilianTime#</TD><TD>#getTrainees.firstname#</TD><TD> #getTrainees.lastname#</TD><TD>#getTrainees.staff_description#</TD><TD>#DollarFormat(getTrainees.fee)#</TD></TR>">
			<cfset count = #count# + 1>
			
			<cfset TotalHonoraria = #TotalHonoraria# + #getTrainees.fee#>
		</cfoutput>
		
		<cfset OutputArray[count] = "<tr><td colspan='6' align='right'><strong>Total Honoraria: </strong></td><td><strong><cfoutput>#DollarFormat(TotalHonoraria)#</cfoutput></strong></td></tr>">
		<cfset count = #count# + 1>
				
		<cfset OutputArray[count] = "</table></body></html>">
		
		<!--- <cfset #report_path# = "E:\INETPUB\WWWROOT\projects\cgi-bin\temp\rpt_temp.htm"> --->
		<cfset temp = #ArrayToList(OutputArray, " ")#>
		<cffile action="write" file="#application.ReportPath#/rpt_temp.htm" nameconflict="overwrite" output="#temp#">
		<cfcontent type="application/vnd.ms-excel" deletefile="NO" file="#application.ReportPath#/rpt_temp.htm">
		
	<cfelse><!---HTML Report has been requested----->
	
		<TABLE ALIGN="Center" BORDER="0" WIDTH="700px" CELLSPACING="0" CELLPADDING="0" style="border: solid 1px navy;">
			<TR>
				<TD colspan="5" style="padding-top: 2px; padding-bottom: 12px; font-size: 15px; text-align: center;"><strong>Scheduled Trainees <cfoutput>#DateFormat(BeginingDate,"m/dd/yyyy")# - #DateFormat(EndingDate,"m/dd/yyyy")#</cfoutput></strong></TD>
			</TR>
			<TR>
				<TD style="border-bottom: solid 2px navy; padding-top: 2px; padding-bottom: 2px;"><strong>Meeting Code</strong></TD>
				<TD style="border-bottom: solid 2px navy; padding-top: 2px; padding-bottom: 2px;"><strong>Meeting Date</strong></TD>
				<TD style="border-bottom: solid 2px navy; padding-top: 2px; padding-bottom: 2px;"><strong>Meeting Time</strong></TD>
				<TD style="border-bottom: solid 2px navy; padding-top: 2px; padding-bottom: 2px;"><strong>Trainee</strong></TD>
				<TD style="border-bottom: solid 2px navy; padding-top: 2px; padding-bottom: 2px;"><strong>Honoraria</strong></TD>
			</TR>
			
			
			<cfset TotalHonoraria = 0>
			
			<cfoutput query="getTrainees">
				
				<!--- Set the starting time minutes --->
				<cfif Mid(GetTrainees.start_time, 3, 2) EQ 50>
					<cfset start_min = 30>
				<cfelse>
					<cfset start_min = Mid(GetTrainees.start_time, 3, 2)>
				</cfif>
		
				<!--- Convert meeting start time to Civilian Time --->
				<cfset TimeCreated = CreateTime(Left(GetTrainees.start_time, 2),start_min,00)>
				<cfset CivilianTime = TimeFormat(TimeCreated,'h:mmtt')>
				<TR>
					<TD style="border-bottom: solid 1px navy; padding-top: 2px; padding-bottom: 2px;">#getTrainees.project_code#</TD>
					<TD style="border-bottom: solid 1px navy; padding-top: 2px; padding-bottom: 2px;">#DateFormat(getTrainees.meeting_date, "mm/dd/yyyy")#</TD>
					<TD style="border-bottom: solid 1px navy; padding-top: 2px; padding-bottom: 2px;">#CivilianTime#</TD>
					<TD style="border-bottom: solid 1px navy; padding-top: 2px; padding-bottom: 2px;">#getTrainees.firstname# #getTrainees.lastname#</TD>
					<TD style="border-bottom: solid 1px navy; padding-top: 2px; padding-bottom: 2px;">#DollarFormat(getTrainees.fee)#</TD>
				</TR>
				<cfset TotalHonoraria = #TotalHonoraria# + #getTrainees.fee#>
			</cfoutput>
			<tr>
				<td colspan='4' align="right" style="padding-top: 6px; padding-bottom: 2px;"><strong>Total Honoraria: </strong></td>
				<td style="padding-top: 6px; padding-bottom: 2px; padding-left: 5px;"><strong><cfoutput>#DollarFormat(TotalHonoraria)#</cfoutput></strong></td>
			</tr>
		</table>
	</cfif>
<cfelse>
&nbsp; &nbsp; <strong>No matching records were found.</strong>
</cfif>
<br><br>
<center><input type="button"  value=" Go Back " onclick="document.location.href='report_trainees.cfm'"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <input type="button"  value=" Print " onclick="javascript: window.print();"></center>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">

