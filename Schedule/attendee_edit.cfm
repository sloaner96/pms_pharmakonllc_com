<!--- 
	*****************************************************************************************
	Name:		attendee_edit.cfm
	Function:	Allows user to update attendance and cis for a meeting
	
	*****************************************************************************************
--->
<HTML>

	<HEAD>
	
	
		<TITLE>Attendee Edit</TITLE>
		
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
	<BODY>


	
<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="getm">
	SELECT m.project_code, m.year, m.month, m.day, m.start_time, m.end_time, m.cis, m.attendees,  m.client_listen, m.mod_listen, m.rowid, s.lastname AS slastname, s.firstname AS sfirstname, mo.lastname AS mlastname, mo.firstname AS mfirstname
	FROM PMSProd.dbo.schedule_meeting_time m, speaker.dbo.spkr_table s, speaker.dbo.spkr_table mo
	WHERE rowid = #url.rowid# AND m.speaker_id *= s.speaker_id AND m.moderator_id *= mo.speaker_id
</CFQUERY>
	
	

	<CFSET bg_color = "E0E0E0">
			<cfoutput><form action="attendee_edit_2.cfm?rowid=#url.rowid#" method="post"></cfoutput>
			<TABLE BGCOLOR="#000080" ALIGN="center" BORDER="0" CELLPADDING="3" CELLSPACING="1">
	<TR> 
		<cfoutput><TD CLASS="tdheader">Meetings for client: #getm.project_code#</TD></cfoutput>
	</TR>
	<TR> 
		<TD>	<!--- Table containing input fields --->
		<TABLE BORDER="0" CELLSPACING="2" CELLPADDING="3">


			<CFOUTPUT QUERY="getm">
			
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
						
			<TR>
				<TD colspan="7"><strong>Meeting:</strong>&nbsp;<font color="##0099FF"><strong>#getm.month#/#getm.day#/#getm.year#,  #TheTime# EST</strong></font></TD>
			</TR>
			<tr><td colspan="7"></td></tr>
			<TR>
				
				<TD STYLE="background-color:#bg_color#;" WIDTH="80"><B>Moderator</B></TD>
				<TD STYLE="background-color:#bg_color#;" WIDTH="80"><B>Speaker</B></TD>
				<TD STYLE="background-color:#bg_color#;" WIDTH="50"><B>Attendees</B></TD>
				<TD STYLE="background-color:#bg_color#;" WIDTH="50"><B>CIs</B></TD>
				<TD STYLE="background-color:#bg_color#;" WIDTH="50"><B>Client<br>Listen Ins</B></TD>
				<TD STYLE="background-color:#bg_color#;" WIDTH="50"><B>Mod.<br>Listen Ins</B></TD>
			</TR>			

				<input type="hidden" name="project_code" value="#getm.project_code#">
			<TR>
				
				<TD STYLE="background-color:#bg_color#;">#trim(getm.mfirstname)# #trim(getm.mlastname)#</td>
				<TD STYLE="background-color:#bg_color#;">#trim(getm.sfirstname)# #trim(getm.slastname)#</td>
				<TD STYLE="background-color:#bg_color#;"><input type="text" name="attendees" value="#getm.attendees#" size="3"></td>
				<TD STYLE="background-color:#bg_color#;"><input type="text" name="cis" value="#getm.cis#" size="3"></td>
				<TD STYLE="background-color:#bg_color#;">
					<textarea name="client_listen" cols="20" rows="3">#getm.client_listen#</textarea>
				</td>
				<TD STYLE="background-color:#bg_color#;">
					<textarea name="mod_listen" cols="20" rows="3">#getm.mod_listen#</textarea>
				</td>
			</TR>
			</CFOUTPUT>
			<TR><TD colspan="7">&nbsp;</TD></TR>
			<tr><TD COLSPAN="2" ALIGN="center">
		<INPUT TYPE="submit"  VALUE="Submit">
		</TD></tr>

		</TABLE>
		</TD>
	</TR>
</TABLE>
		</form>
					
			
	</BODY>

</HTML>