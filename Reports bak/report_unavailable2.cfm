<!------------------
report_unavailable2.cfm

Shows unavailable moderators for a period of time

----------------------->

<cfif NOT isDefined("URL.report")>
	<cfinclude template="error_handler.cfm">
	<cfabort>
</cfif>

<cfset BeginingDate = CreateDate(Year(form.begin_date), Month(form.begin_date), Day(form.begin_date))>
<cfset EndingDate = CreateDate(Year(form.end_date), Month(form.end_date), Day(form.end_date))>

	
	<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="GetUnavailable">
			SELECT a.year, a.month, a.day, a.owner_id, sp.lastname, sp.firstname 
			FROM availability_time a, spkr_table sp
			WHERE a.owner_id = sp.speaker_id AND sp.type = 'MOD'
			AND allday = 0 
			AND (year BETWEEN #datepart('yyyy',BeginingDate)# AND #datepart('yyyy',EndingDate)#)
			<cfif month(BeginingDate) EQ 12>
			AND (a.month = 12 OR a.month = 1)
			<cfelse>
			AND (a.month BETWEEN #datepart('m',BeginingDate)# AND #datepart('m',EndingDate)#)
			</cfif>
			ORDER BY a.year, a.month, a.day
		</CFQUERY>

<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Unavailable Report" showCalendar="0">




<p>&nbsp;</p>
<cfif getUnavailable.recordcount>
	<cfif #URL.report# EQ "EXCEL">
		
		<cfset OutputArray = ArrayNew(1)>
		<cfset count = 1>
		
		<cfset OutputArray[count] = "<html><head></head><body><TABLE BORDER='1' CELLSPACING='0' CELLPADDING='0'><TR>">
		<cfset count = #count# + 1>
		
		<cfset OutputArray[count] = "<TD><strong>Unavailable Date</strong></TD><TD><strong>Moderator First Name</strong></TD><TD><strong>Moderator Last Name</strong></TD></TR>">
		<cfset count = #count# + 1>

		<cfoutput query="getUnavailable">
		
			<cfset unavaildate = CreateDate(#GetUnavailable.year#, #GetUnavailable.month#, #GetUnavailable.day#)>
				<cfif DayOfWeek(unavaildate) NEQ 1 AND DayOfWeek(unavaildate) NEQ 7 AND DayOfWeek(unavaildate) NEQ 6>
			
			<cfset OutputArray[count] = "<TR><TD>#DateFormat(unavaildate, 'mm/dd/yyyy')#</TD><TD>#getUnavailable.firstname#</TD><TD>#getUnavailable.lastname#</TD></TR>">
			<cfset count = #count# + 1>
				</cfif>
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
				<td height="40" align="center" colspan="5"><strong><font size="3">Unavailable Report</font></strong></td>
			</tr>
			<TR>
				<TD style="border-bottom: solid 2px navy; padding-left: 5px; padding-top: 2px; padding-bottom: 2px;"><strong>Unavailable Date</strong></TD>
				<TD style="border-bottom: solid 2px navy; padding-top: 2px; padding-bottom: 2px;"><strong>Moderator</strong></TD>
			</TR>
			
			
			<cfoutput query="getUnavailable">
				<cfset unavaildate = CreateDate(#GetUnavailable.year#, #GetUnavailable.month#, #GetUnavailable.day#)>
					<cfif DayOfWeek(unavaildate) NEQ 1 AND DayOfWeek(unavaildate) NEQ 7 AND DayOfWeek(unavaildate) NEQ 6>
				
						<TR>
							<TD style="border-bottom: solid 1px navy; padding-top: 2px; padding-bottom: 2px; padding-left: 5px;">#DateFormat(unavaildate, "mm/dd/yyyy")#</TD>
							<TD style="border-bottom: solid 1px navy; padding-top: 2px; padding-bottom: 2px;">#trim(getUnavailable.firstname)# #trim(getUnavailable.lastname)#</TD>
						</TR>
					</cfif>
			</cfoutput>
		</table>
	</cfif>
<cfelse>
&nbsp; &nbsp; <strong>No matching records were found.</strong>
</cfif>
<br><br>
<center><input type="button" value=" Go Back " onclick="document.location.href='report_unavailable.cfm'"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <input type="button" value=" Print " onclick="javascript: window.print();"></center>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
