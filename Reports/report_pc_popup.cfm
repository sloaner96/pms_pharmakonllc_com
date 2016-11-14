<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Project Code Schedule Report (Printable Version)</title>
		<LINK REL=STYLESHEET HREF="PIW1STYLE.CSS" TYPE="TEXT/CSS">
		<STYLE>
			TD {
					font-family : Verdana, Geneva, Arial;
					font-size : xx-small;
					text-align: center;
					background-color: #FFFFFF;
				}
	
			.DAYS {
					font-family : Verdana, Geneva, Arial;
					font-size : xx-small;
					font-weight: bold;
					text-align: center;
				}
			.WEEKS {
					font-family : ArialBold;
					font-size : xx-small;
					text-align: center;
				}
		</STYLE>		
				
</HEAD>
			
		<BODY BGCOLOR="FFFFFF" MARGINHEIGHT="0" MARGINWIDTH="0">
				<FORM NAME="form" action="" METHOD="post">
				<TABLE ALIGN="left" WIDTH="650" BORDER="0" CELLPADDING="5" CELLSPACING="5">
					<CFQUERY DATASOURCE="#application.projdsn#" NAME="meetingDT">
						SELECT *
						FROM ScheduleSpeaker
						WHERE project_code = '#session.project_code#'
						ORDER BY year,Month,Day,start_time;
					</CFQUERY>
					<TR>
						<TD COLSPAN="5" ALIGN="left" STYLE="text-align: left; font-size : small;">
						Scheduled Meetings for Project Code: <B><CFOUTPUT>#session.project_code#</CFOUTPUT></B><BR><HR><BR>
						</TD>	
					</TR>
					<TR><TD COLSPAN="5"><TABLE width="600" BORDER="0" CELLPADDING="5" CELLSPACING="5"><TR>
					<TD><strong>Project Code</strong></TD><TD><strong>Date</strong></TD><TD><strong>Time</strong></TD><TD></TD><TD><strong>Moderator</strong></TD><TD><strong>Speaker</strong></TD></TR><TR>
					<CFSET StrLastCol="">
					<CFOUTPUT QUERY="meetingDT">
						<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="GetModerators">
							SELECT DISTINCT firstname, lastname
							FROM Speaker
							WHERE speakerid='#meetingDT.speakerid#'; 
						</CFQUERY>
						<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="GetSpeakers">
							SELECT DISTINCT firstname, lastname
							FROM Speaker
							WHERE speakerid='#meetingDT.speakerid#'; 
						</CFQUERY>
						<TD>
						<cfif StrLastCol NEQ #session.project_code#>
						#session.project_code#
						<CFSET StrLastCol = "#session.project_code#">
						</CFIF></TD>
						
						<cfinvoke 
							component="pms.com.cfc_time_conversion" 
							method="toCivilian" 
							returnVariable="CivilianTime" 
							BeginMilitary="#meetingDT.start_time#"
							EndMilitary="#meetingDT.end_time#"
						>
						<cfscript>
							oCivTime = createObject("component","pms.com.cfc_time_conversion");
							TheTime = oCivTime.ConCatTime(#CivilianTime#);
						</cfscript>
						
						<TD>#meetingDT.month#/#meetingDT.day#/#meetingDT.year#</TD>
						<TD>#TheTime# EST</TD><TD></TD>
						<TD>#GetModerators.firstname# #GetModerators.lastname#</TD>
						<TD>#GetSpeakers.firstname# #GetSpeakers.lastname#</TD></TR>
					</CFOUTPUT>
					</TR>
					<tr><td height="20" colspan="3">&nbsp;</td></tr>
					<TR><TD COLSPAN="3"><br><input type="button"  value="Print" onClick="window.print()"></TD><TD COLSPAN="3"><br><input type="button"  value="Close" onClick="window.close()"></TD></TR>
</TR></TABLE></TD>
				</TABLE>
			</FORM>
		</BODY>
	</HTML>
