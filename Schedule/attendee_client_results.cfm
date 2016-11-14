<!--- 
	*****************************************************************************************
	Name:		attendee_client_results.cfm
	
	Function:	Displays meetings that have taken place for the project selected on the previous page.
	History:	
	
	*****************************************************************************************
---> 
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Attendee Search Results" showCalendar="0">

		<SCRIPT LANGUAGE="JavaScript">
			//opens popup window	
			function NewWindow(mypage, myname, w, h, scroll) {
			   var winl = (screen.width - w) / 2;
			   var wint = (screen.height - h) / 2;
			   winprops = 'height='+h+',width='+w+',top='+wint+',left='+winl+',scrollbars='+scroll+',resizable'
			   win = window.open(mypage, myname, winprops)
			   if (parseInt(navigator.appVersion) >= 4) { 
			     win.window.focus(); 
			   }
			}
		</SCRIPT>
		
<!--- pull meetings that have already taken place --->			
<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="getm">
	SELECT m.project_code, m.year, m.month, m.day, m.start_time, m.end_time, m.cis, m.attendees, m.show, m.noshow, m.rowid, s.lastname AS slastname, s.firstname AS sfirstname, mo.lastname AS mlastname, mo.firstname AS mfirstname
	FROM PMSDEV.dbo.schedule_meeting_time m, speaker.dbo.spkr_table s, speaker.dbo.spkr_table mo
	WHERE <cfif ISDefined("form.project_code")> project_code = '#form.project_code#' <cfelse> project_code = '#url.project_code#'</cfif> AND (year <= #year(now())# AND month <= #month(now())# AND day <= #year(now())#) AND m.speaker_id *= s.speaker_id AND m.moderator_id *= mo.speaker_id
	ORDER BY m.year DESC, m.month DESC, m.day DESC, m.start_time
</CFQUERY>
	<CFSET bg_color = "E0E0E0">
			
<TABLE ALIGN="center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="90%">
	<TR> 
		<cfoutput><TD><strong>Meetings for client: #getm.project_code#</strong></TD></cfoutput>
	</TR>
	<TR> 
		<TD>	<!--- Display meeting info --->
		<TABLE WIDTH="99%" BORDER="0" CELLSPACING="2" CELLPADDING="3">
			<TR>
				<TD colspan="7">To edit attendance, click on the Edit Attendance link next to the appropriate meeting.</TD>
			</TR>
			<CFOUTPUT>
			<TR bgcolor="##eeeeee">
				<TD WIDTH="80"><B>Date</B></TD>
				<TD WIDTH="80"><B>Time</B></TD>
				<TD WIDTH="80"><B>Moderator</B></TD>
				<TD WIDTH="80"><B>Speaker</B></TD>
				<TD WIDTH="50"><B>Attendees</B></TD>
				<TD WIDTH="50"><B>CIs</B></TD>
				<TD WIDTH="50"><B>Show<br>Rate</B></TD>
				<TD WIDTH="50"><B>No Show<br>Rate</B></TD>
				<TD WIDTH="10">&nbsp;</TD>
			</TR>
			</CFOUTPUT>
			<CFOUTPUT QUERY="getm">
			<!--- convert time to civilian --->
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
			
			<TR>
				<TD>#getm.month#/#getm.day#/#getm.year#</TD>
				<TD>#TheTime# EST</td>
				<TD>#trim(getm.mfirstname)# #trim(getm.mlastname)#</td>
				<TD>#trim(getm.sfirstname)# #trim(getm.slastname)#</td>
				<TD>#getm.attendees#</td>
				<TD>#getm.cis#</td>
					<cfset showper = getm.show * 100>
				<TD>#decimalFormat(showper)#%</td>
					<cfset noshowper = getm.noshow * 100>
				<TD>#decimalFormat(noshowper)#%</td>
				<td>
				<A HREF="attendee_edit.cfm?&rowid=#getm.rowid#&no_menu='1'" onclick="NewWindow(this.href,'name','700','300','yes');return false;">Edit Attendance</a>
				</td>
			</TR>
			</CFOUTPUT>
			<TR><TD colspan="7">&nbsp;</TD></TR>
			<form action="attendee_client_select.cfm" method="post">
			<TR>
				<TD><INPUT TYPE="submit"  VALUE="Search Again"></TD>
			</TR>
			</form>
		</TABLE>
		</TD>
	</TR>
</TABLE>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
