<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Attendance Report" showCalendar="0">


<!--- pull meetings --->
<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="getm">
	SELECT m.project_code, m.year, m.month, m.day, m.start_time, m.end_time, m.cis, m.attendees, m.show, m.noshow, m.rowid, s.lastname AS slastname, s.firstname AS sfirstname, mo.lastname AS mlastname, mo.firstname AS mfirstname, r.recruiter_name, c.conf_company_name, cp.description, m.client_listen, m.mod_listen
	FROM PMSprod.dbo.schedule_meeting_time m, speaker.dbo.spkr_table s, speaker.dbo.spkr_table mo, PMSProd.dbo.piw p, PMSProd.dbo.recruiter r, PMSProd.dbo.conference_company c, PMSProd.dbo.client_proj cp
	WHERE  (m.year <= #year(now())# AND m.month <= #month(now())# AND m.day <= #year(now())#) AND m.speaker_id *= s.speaker_id AND m.moderator_id *= mo.speaker_id AND m.project_code = p.project_code AND p.recruiting_company *= r.ID AND p.conference_company *= c.ID AND m.project_code = cp.client_proj
	ORDER BY m.year, m.month, m.day
</CFQUERY>

<!--- get total attendees --->
<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="geta">
	SELECT SUM(m.attendees) AS totala
	FROM PMSprod.dbo.schedule_meeting_time m, speaker.dbo.spkr_table s, speaker.dbo.spkr_table mo, PMSProd.dbo.piw p, PMSProd.dbo.recruiter r, PMSProd.dbo.conference_company c, PMSProd.dbo.client_proj cp
	WHERE  (m.year <= #year(now())# AND m.month <= #month(now())# AND m.day <= #year(now())#) AND m.speaker_id *= s.speaker_id AND m.moderator_id *= mo.speaker_id AND m.project_code = p.project_code AND p.recruiting_company *= r.ID AND p.conference_company *= c.ID AND m.project_code = cp.client_proj
</CFQUERY>

<!--- get total cis --->
<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="getc">
	SELECT SUM(m.cis) AS totalc
	FROM PMSProd.dbo.schedule_meeting_time m, speaker.dbo.spkr_table s, speaker.dbo.spkr_table mo, PMSProd.dbo.piw p, PMSProd.dbo.recruiter r, PMSProd.dbo.conference_company c, PMSProd.dbo.client_proj cp
	WHERE  (m.year <= #year(now())# AND m.month <= #month(now())# AND m.day <= #year(now())#) AND m.speaker_id *= s.speaker_id AND m.moderator_id *= mo.speaker_id AND m.project_code = p.project_code AND p.recruiting_company *= r.ID AND p.conference_company *= c.ID AND m.project_code = cp.client_proj
</CFQUERY>

</head>

<body>
<!--- <table border="1" cellpadding="2" cellspacing="0">
	<tr>
		<td><strong>Recruiter</strong></td>
		<td><strong>Conference</strong></td>
		<td><strong>Project</strong></td>
		<td><strong>Meeting Code</strong></td>
		<td><strong>Date</strong></td>
		<td><strong>Time (EST)</strong></td>
		<td><strong>Moderator</strong></td>
		<td><strong>Speaker</strong></td>
		<td><strong>Attendees</strong></td>
		<td><strong>Cis</strong></td>
		<td><strong>Show Rate</strong></td>
		<td><strong>No Show Rate</strong></td>
		<td><strong>Client Listen Ins</strong></td>
		<td><strong>Mod Listen Ins</strong></td>
	</tr>
			<cfset totalclient = 0>
			<cfset totalmod = 0>
	<cfoutput query="getm">
		<cfif len(getm.client_listen) GT 0>
			<cfset totalclient = totalclient + 1>
		</cfif>
		<cfif len(getm.mod_listen) GT 0>
			<cfset totalmod = totalmod + 1>
		</cfif>

	
	
		<cfinvoke 
			component="cfc_time_conversion" 
			method="toCivilian" 
			returnVariable="CivilianTime" 
			BeginMilitary="#getm.start_time#"
			EndMilitary="#getm.end_time#"
		>
		<cfscript>
			oCivTime = createObject("component","cfc_time_conversion");
			TheTime = oCivTime.ConCatTime(#CivilianTime#);
		</cfscript>
	<tr>
		<td>#getm.recruiter_name#</td>
		<td>#getm.conf_company_name#</td>
		<td>#getm.description#</td>
		<td>#getm.project_code#</td>
		<td>#getm.month#/#getm.day#/#getm.year#</td>
		<td>#TheTime#</td>
		<td>#getm.mfirstname# #getm.mlastname#</td>
		<td>#getm.sfirstname# #getm.slastname#</td>
		<td>#getm.attendees#</td>
		<td>#getm.cis#</td>
			<cfset showper = getm.show * 100>
		<td>#decimalFormat(showper)#%</td>
			<cfset noshowper = getm.noshow * 100>
		<td>#decimalFormat(noshowper)#%</td>
		<td>#getm.client_listen#</td>
		<td>#getm.mod_listen#</td>
	</tr>
	</cfoutput>
	<tr>
		<td colspan="7">&nbsp;</td>
		<td><strong>Grand Total</strong></td>
		<cfoutput>
		<td>#geta.totala#</td>
		<td>#getc.totalc#</td>
		<cfset totals = geta.totala/getc.totalc>
		<cfset totalsp = totals * 100>
		<td>#decimalFormat(totalsp)#%</td>
		<cfset totalns = 100 - totalsp>
		<td>#decimalFormat(totalns)#%</td>
		<td>#totalclient#</td>
		<td>#totalmod#</td>
		</cfoutput>
	</tr>
</table>
 --->
<!--- ************************To excel********************************************************** --->
<cfset report_path = "#application.REPORTPATH#\report_attendance2XL.htm">
<cfset report_title_color = "gray">
<cfset report_col_color = "white">
<cfset report_columns = '14'>
<cfset report_title = "Attendance Report">

<!--- write the headings --->
	<cfoutput>
		<cffile action="write" file="#report_path#" nameconflict="overwrite" output="<html><head><title></title></head>">
		<cffile action="append" file="#report_path#" nameconflict="overwrite" output="<body><table border=1>">
		<cffile action="append" file="#report_path#" nameconflict="overwrite" output="<tr bgcolor=#report_title_color#><td colspan=#report_columns#><font name=arial size=+2>#report_title# as of #dateFormat(Now(), 'mm/dd/yyyy')#</font></td></tr>">
		<cffile action="append" file="#report_path#" nameconflict="overwrite" output="<tr bgcolor=#report_col_color#><font name=arial><td><b>Recruiter</b></td><td><b>Conference</b></td><td><b>Project</b></td><td><b>Meeting Code</b></td><td><b>Date</b></td><td><b>Time</b></td><td><b>Moderator</b></td><td><b>Speaker</b></td><td><b>Attendees</b></td><td><b>Cis</b></td><td><b>Show Rate</b></td><td><b>No Show Rate</b></td><td><b>Client Listen Ins</b></td><td><b>Moderator Listen Ins</b></td></font></tr>">
</cfoutput>		
		
		<!--- Write body of report --->
			<cfset totalclient = 0>
			<cfset totalmod = 0>
	<cfoutput query="getm">
		<cfif len(getm.client_listen) GT 0>
			<cfset totalclient = totalclient + 1>
		</cfif>
		<cfif len(getm.mod_listen) GT 0>
			<cfset totalmod = totalmod + 1>
		</cfif>
	
	
		<cfinvoke 
			component="pms.com.cfc_time_conversion" 
			method="toCivilian" 
			returnVariable="CivilianTime" 
			BeginMilitary="#getm.start_time#"
			EndMilitary="#getm.end_time#"
		>
		<cfscript>
			oCivTime = createObject("component","pms.com.cfc_time_conversion");
			TheTime = oCivTime.ConCatTime(#CivilianTime#);
		</cfscript>
			
			<cfset showper = getm.show * 100>
			<cfset noshowper = getm.noshow * 100>
		
		<cffile action="append" file="#report_path#" nameconflict="overwrite" output="<TR><TD>#getm.recruiter_name#</TD><TD>#getm.conf_company_name#</TD><td>#getm.description#</td><td>#getm.project_code#</td><TD>#getm.month#/#getm.day#/#getm.year#</TD><TD>#TheTime#</TD><TD>#getm.mfirstname# #getm.mlastname#</TD><TD>#getm.sfirstname# #getm.slastname#</TD><TD>#getm.attendees#</TD><TD>#getm.cis#</TD><TD>#decimalFormat(showper)#%</TD><TD>#decimalFormat(noshowper)#%</TD><TD>#getm.client_listen#</TD><TD>#getm.mod_listen#</TD>">
	</cfoutput>
	
	<cfoutput>
	<cfset totals = geta.totala/getc.totalc>
		<cfset totalsp = totals * 100>
		<!--- <td>#decimalFormat(totalsp)#%</td> --->
		<cfset totalns = 100 - totalsp>
		<!--- <td>#decimalFormat(totalns)#%</td>
		<td>#totalclient#</td>
		<td>#totalmod#</td> --->
	<cffile action="append" file="#report_path#" nameconflict="overwrite" output="<TR><TD></TD><TD></TD><TD></TD><TD></TD><TD></TD><TD></TD><TD></TD><TD><strong>Totals</strong>:</TD><TD><b>#geta.totala#</b></TD><td><b>#getc.totalc#</b><TD><b>#decimalFormat(totalsp)#%</b></TD><TD><b>#decimalFormat(totalns)#%</b></TD><TD><b>#totalclient#</b></TD><TD><b>#totalmod#</b></TD></TR>">
	</cfoutput>	
		
		
	<cfoutput>
	<cffile action="append" file="#report_path#" nameconflict="overwrite" output="</table></body></html>">
	<!--- display the file --->
	<cfcontent type="application/vnd.ms-excel" deletefile="NO" file="#report_path#">
	</cfoutput>

<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
