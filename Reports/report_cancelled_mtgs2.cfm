<!------------------
report_cancelled_mtgs2.cfm

Shows cancelled meetings for a period of time and/or by project

----------------------->

<cfif NOT isDefined("URL.report")>
	<cfinclude template="error_handler.cfm">
	<cfabort>
</cfif>
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Cancelled Meeting Report" showCalendar="0">

<cfset BeginingDate = CreateDate(Year(form.begin_date), Month(form.begin_date), Day(form.begin_date))>
<cfset EndingDate = CreateDate(Year(form.end_date), Month(form.end_date), Day(form.end_date))>


	<CFQUERY DATASOURCE="#application.projdsn#" NAME="GetCancelled">
		SELECT m.project_code, m.start_time, m.end_time, m.meeting_date,
				s.staff_id AS speakerid,
				mp.lastname AS mod_lname, mp.firstname AS mod_fname
		FROM projman.dbo.ScheduleSpeaker m, projman.dbo.ScheduleSpeaker s, speaker.dbo.Speaker mp 
		WHERE (m.meeting_date BETWEEN #BeginingDate# AND #EndingDate#) AND m.staff_type = 1
		AND m.status = 1 AND m.staff_id = mp.speakerid 
		AND (m.meeting_code *= s.meeting_code AND s.staff_type = 2) 
		<cfif #form.projcode# NEQ 0>AND m.project_code = '#form.projcode#'</cfif> 
		ORDER BY m.meeting_date, m.start_time, m.project_code					
	</CFQUERY>

<p>&nbsp;</p>
<cfif getCancelled.recordcount>
	<cfif #URL.report# EQ "EXCEL">
		
		<cfset OutputArray = ArrayNew(1)>
		<cfset count = 1>
		
		<cfset OutputArray[count] = "<html><head></head><body><TABLE BORDER='1' CELLSPACING='0' CELLPADDING='0'><TR>">
		<cfset count = #count# + 1>
		
		<cfset OutputArray[count] = "<TD><strong>Project Code</strong></TD><TD><strong>Meeting Date</strong></TD><TD><strong>Meeting Time</strong></TD><TD><strong>Moderator</strong></TD><TD><strong>Speaker</strong></TD></TR>">
		<cfset count = #count# + 1>

		
		<cfoutput query="getCancelled">
				<!--- Set the starting time minutes --->
				<cfif Mid(GetCancelled.start_time, 3, 2) EQ 50>
					<cfset start_min = 30>
				<cfelse>
					<cfset start_min = Mid(GetCancelled.start_time, 3, 2)>
				</cfif>
		
				<!--- Convert meeting start time to Civilian Time --->
				<cfset TimeCreated = CreateTime(Left(GetCancelled.start_time, 2),start_min,00)>
				<cfset CivilianTime = TimeFormat(TimeCreated,'h:mmtt')>
				
				<cfscript>
					PIW = createObject("component","pms.com.cfc_get_piwinfo");
				</cfscript>
				<cfif trim(getCancelled.speakerid) EQ "">
					<cfset speaker = 1>
				<cfelse>
					<cfset speaker = #getCancelled.speakerid#>
				</cfif>
				<cfscript>
					GetSpkr = PIW.getModSpker(cfcID="#speaker#");
				</cfscript>
			
			<cfset OutputArray[count] = "<TR><TD>#getCancelled.project_code#</TD><TD>#DateFormat(getCancelled.meeting_date, 'mm/dd/yyyy')#</TD><TD>#CivilianTime#</TD><TD>#getCancelled.mod_fname# #getCancelled.mod_lname#</TD><TD>#GetSpkr#</TD></TR>">
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
				<td height="40" align="center" colspan="5"><strong><font size="3">Cancelled Meetings</font></strong></td>
			</tr>
			<TR>
				<TD style="border-bottom: solid 2px navy; padding-left: 5px; padding-top: 2px; padding-bottom: 2px;"><strong>Project Code</strong></TD>
				<TD style="border-bottom: solid 2px navy; padding-top: 2px; padding-bottom: 2px;"><strong>Meeting Date</strong></TD>
				<TD style="border-bottom: solid 2px navy; padding-top: 2px; padding-bottom: 2px;"><strong>Meeting Time</strong></TD>
				<TD style="border-bottom: solid 2px navy; padding-top: 2px; padding-bottom: 2px;"><strong>Moderator</strong></TD>
				<TD style="border-bottom: solid 2px navy; padding-top: 2px; padding-bottom: 2px;"><strong>Speaker</strong></TD>
			</TR>
			
			
			<cfoutput query="getCancelled">
				
				
				<!--- Set the starting time minutes --->
				<cfif Mid(GetCancelled.start_time, 3, 2) EQ 50>
					<cfset start_min = 30>
				<cfelse>
					<cfset start_min = Mid(GetCancelled.start_time, 3, 2)>
				</cfif>
		
				<!--- Convert meeting start time to Civilian Time --->
				<cfset TimeCreated = CreateTime(Left(GetCancelled.start_time, 2),start_min,00)>
				<cfset CivilianTime = TimeFormat(TimeCreated,'h:mmtt')>
				
				<cfscript>
					PIW = createObject("component","pms.com.cfc_get_piwinfo");
				</cfscript>
				<cfif trim(getCancelled.speakerid) EQ "">
					<cfset speaker = 1>
				<cfelse>
					<cfset speaker = #getCancelled.speakerid#>
				</cfif>
				<cfscript>
					GetSpkr = PIW.getModSpker(cfcID="#speaker#");
				</cfscript>
				
				<TR>
					<TD style="border-bottom: solid 1px navy; padding-top: 2px; padding-left: 5px; padding-bottom: 2px;">#getCancelled.project_code#</TD>
					<TD style="border-bottom: solid 1px navy; padding-top: 2px; padding-bottom: 2px;">#DateFormat(getCancelled.meeting_date, "mm/dd/yyyy")#</TD>
					<TD style="border-bottom: solid 1px navy; padding-top: 2px; padding-bottom: 2px;">#CivilianTime#</TD>
					<TD style="border-bottom: solid 1px navy; padding-top: 2px; padding-bottom: 2px;">#trim(getCancelled.mod_fname)# #trim(getCancelled.mod_lname)#</TD>
					<TD style="border-bottom: solid 1px navy; padding-top: 2px; padding-bottom: 2px;">#trim(GetSpkr)#</TD>
				</TR>
			</cfoutput>
		</table>
	</cfif>
<cfelse>
&nbsp; &nbsp; <strong>No matching records were found.</strong>
</cfif>
<br><br>
<center><input type="button"  value=" Go Back " onclick="document.location.href='report_cancelled_mtgs.cfm'"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <input type="button"  value=" Print " onclick="javascript: window.print();"></center>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">

