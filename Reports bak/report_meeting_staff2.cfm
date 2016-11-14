<!------------------
report_meeting_staff2.cfm

Shows speakers and moderators for a project

----------------------->

<cfif NOT isDefined("URL.report")>
	<cfinclude template="error_handler.cfm">
	<cfabort>
</cfif>
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Program Staff Report" showCalendar="0">



	<CFQUERY DATASOURCE="#application.projdsn#" NAME="GetStaff">
		SELECT m.project_code, m.start_time, m.meeting_date, m.staff_id, m.sequence, m.meeting_code,
		sp.lastname, sp.firstname
		FROM PMSProd.dbo.schedule_meeting_time m, speaker.dbo.spkr_table sp
		WHERE m.status = 0 AND m.staff_type = 1 AND m.staff_id *= sp.speaker_id
		AND m.project_code = '#form.projcode#'
		ORDER BY m.meeting_date, m.meeting_code					
	</CFQUERY>


</head>

<body>
<p>&nbsp;</p>
<cfif GetStaff.recordcount>
	<cfif #URL.report# EQ "EXCEL">
		
		<cfset OutputArray = ArrayNew(1)>
		<cfset count = 1>
		
		<cfset OutputArray[count] = "<html><head></head><body><TABLE BORDER='1' CELLSPACING='0' CELLPADDING='0'><TR><TD colspan='6' style='padding-top: 2px; padding-bottom: 12px; font-size: 15px; text-align: center;'><strong>Scheduled Staff for  <cfoutput>#form.projcode#</cfoutput></strong></TD></TR><TR>">
		<cfset count = #count# + 1>
		
		<cfset OutputArray[count] = "<TD style='background-color: ##CCCCCC;'><strong>Meeting Code</strong></TD><TD style='background-color: ##CCCCCC;'><strong>Sequence</strong></TD><TD style='background-color: ##CCCCCC;'><strong>Meeting Date</strong></TD><TD style='background-color: ##CCCCCC;'><strong>Meeting Time</strong></TD><TD style='background-color: ##CCCCCC;'><strong>Moderator</strong></TD><TD style='background-color: ##CCCCCC;'><strong>Speaker</strong></TD></TR>">
		<cfset count = #count# + 1>
		
		
		<cfoutput query="getStaff">
		
				<CFQUERY DATASOURCE="#application.projdsn#" NAME="GetSpkr">
						SELECT sp.lastname + ',' + ' ' + sp.firstname AS speaker, m.staff_id
						FROM PMSProd.dbo.schedule_meeting_time m, speaker.dbo.spkr_table sp
						WHERE m.staff_type = 2 AND m.staff_id *= sp.speaker_id
						AND m.meeting_code = '#getStaff.meeting_code#'					
					</CFQUERY>
		
		
			<!--- Set the starting time minutes --->
				<cfif Mid(getStaff.start_time, 3, 2) EQ 50>
					<cfset start_min = 30>
				<cfelse>
					<cfset start_min = Mid(getStaff.start_time, 3, 2)>
				</cfif>
		
				<!--- Convert meeting start time to Civilian Time --->
				<cfset TimeCreated = CreateTime(Left(getStaff.start_time, 2),start_min,00)>
				<cfset CivilianTime = TimeFormat(TimeCreated,'h:mmtt')>
				
				<cfif getStaff.staff_id EQ 0>
					<cfset mods = 'TBD'>
				<cfelse>
					<cfset mods = #trim(getStaff.lastname)# &',' & ' ' & #getStaff.firstname#>
				</cfif>
				
				<cfif getSpkr.staff_id EQ 0>
					<cfset spkr = 'TBD'>
				<cfelseif getSpkr.staff_id EQ ''>
					<cfset spkr = 'N/A'>
				<cfelse>
					<cfset spkr = #trim(getSpkr.speaker)#>
				</cfif>
						
			<cfset OutputArray[count] = "<TR><TD>#getStaff.meeting_code#</TD><TD>#getStaff.sequence#</TD><TD>#DateFormat(getStaff.meeting_date, 'mm/dd/yyyy')#</TD><TD>#CivilianTime#</TD><TD>#mods#</TD><TD>#spkr#&nbsp;</TD></TR>">
			<cfset count = #count# + 1>
			
		</cfoutput>
				
		<cfset OutputArray[count] = "</table></body></html>">
		
		<!--- <cfset #report_path# = "E:\INETPUB\WWWROOT\projects\cgi-bin\temp\rpt_temp.htm"> --->
		<cfset temp = #ArrayToList(OutputArray, " ")#>
		<cffile action="write" file="#application.ReportPath#/rpt_temp.htm" nameconflict="overwrite" output="#temp#">
		<cfcontent type="application/vnd.ms-excel" deletefile="NO" file="#application.ReportPath#/rpt_temp.htm">
		
	<cfelse><!---HTML Report has been requested----->
	
		<TABLE ALIGN="Center" BORDER="0" CELLSPACING="1" CELLPADDING="3" bgcolor="#666666">
			<TR>
				<TD height="45" valign="top" colspan="6" style="padding-top: 2px; padding-bottom: 12px; font-size: 15px; text-align: center; background-color:#ffffff;"><font color="navy"><strong>Scheduled Staff for <cfoutput>#form.projcode#</cfoutput></strong></font></TD>
			</TR>
			<TR bgcolor="#444444">
				<TD><strong style="color:#ffffff;">Meeting Codee</strong></TD>
				<TD><strong style="color:#ffffff;">Sequence</strong></TD>
				<TD><strong style="color:#ffffff;">Meeting Date</strong></TD>
				<TD><strong style="color:#ffffff;">Meeting Time</strong></TD>
				<TD><strong style="color:#ffffff;">Moderator</strong></TD>
				<TD><strong style="color:#ffffff;">Speaker</strong></TD>
			</TR>
			
			
			<cfoutput query="getStaff">
			
					<CFQUERY DATASOURCE="#application.projdsn#" NAME="GetSpkr">
						SELECT sp.lastname + ',' + ' ' + sp.firstname AS speaker, m.staff_id
						FROM PMSProd.dbo.schedule_meeting_time m, speaker.dbo.spkr_table sp
						WHERE m.staff_type = 2 AND m.staff_id *= sp.speaker_id
						AND m.meeting_code = '#getStaff.meeting_code#'					
					</CFQUERY>
				
				<!--- Set the starting time minutes --->
				<cfif Mid(getStaff.start_time, 3, 2) EQ 50>
					<cfset start_min = 30>
				<cfelse>
					<cfset start_min = Mid(getStaff.start_time, 3, 2)>
				</cfif>
		
				<!--- Convert meeting start time to Civilian Time --->
				<cfset TimeCreated = CreateTime(Left(getStaff.start_time, 2),start_min,00)>
				<cfset CivilianTime = TimeFormat(TimeCreated,'h:mmtt')>
				<TR <cfif getStaff.currentrow MOD(2) EQ 0>bgcolor="##ffffff"<cfelse>bgcolor="##eeeeee"</cfif>>
					<TD>#getStaff.meeting_code#</TD>
					<TD>#getStaff.sequence#&nbsp;</TD>
					<TD>#DateFormat(getStaff.meeting_date, "mm/dd/yyyy")#</TD>
					<TD>#CivilianTime#</TD>
					<TD>
						<cfif getStaff.staff_id EQ 0>
						TBD
						<cfelse>
						#trim(getStaff.lastname)#, #getStaff.firstname#
						</cfif>
					</TD>
					<TD>
						<cfif getSpkr.staff_id EQ 0>
						TBD
						<cfelseif getSpkr.staff_id EQ ''>
						N/A
						<cfelse>
						#trim(getSpkr.speaker)#&nbsp;
						</cfif>
					</TD>
				</TR>
			</cfoutput>
		</table>
	</cfif>
<cfelse>
&nbsp; &nbsp; <strong>No matching records were found.</strong>
</cfif>
<br><br>
<center><input type="button" value=" Go Back " onclick="document.location.href='report_meeting_staff.cfm'"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <input type="button" value=" Print " onclick="javascript: window.print();"></center>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">

