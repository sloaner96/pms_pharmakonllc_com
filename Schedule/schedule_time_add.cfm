<!--- 
	*****************************************************************************************
	Name:		schedule_time_add.cfm
	Function:	Displays time schedule for moderator or speaker
	
	*****************************************************************************************
--->
<HTML>

	<HEAD>
		<TITLE>Available times for <CFOUTPUT>#URL.month#/#URL.day#/#URL.year#</CFOUTPUT></TITLE>
		
		<LINK REL=STYLESHEET HREF="PIW1STYLE.CSS" TYPE="TEXT/CSS">
		<SCRIPT LANGUAGE="JavaScript" src="popup_help.js"></script>
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


	<CFSET year = URL.year>
	<CFSET month = URL.month>
	<CFSET day = URL.day>	
		

	
	
	<!--- Pull updated meeting times --->
	<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="avail">
		SELECT *
		FROM availability_time
		WHERE owner_id = #url.id# AND year = #year# AND month = #month# AND day = #day#
	</CFQUERY>
	
	<cfif avail.recordcount>
		<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="getReason">
			SELECT code, description
			FROM codes
			WHERE code_type = 'UREAS' AND code = #avail.u_reason#
		</CFQUERY>
	</cfif>
	
	

	<!--- Display existing meeting info --->
	<table cellspacing="0" cellpadding="1" WIDTH="550" HEIGHT="50">
			<TR ALIGN="center">
				<Th style="border-left: solid 1px #6699FF; border-right: solid 1px #6699FF; border-top: solid 1px #6699FF" bgcolor="#99CCFF" colspan="10"><strong>Times Available</strong>&nbsp;&nbsp;&nbsp;&nbsp;
				A = Available&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="##FF0000">NA</font> = Unavailable</Th>
			</TR>
			<TR ALIGN="center">
				<TD style="border-left: solid 1px #6699FF; border-right: solid 1px #6699FF" class="header" colspan="10">&nbsp;</TD>
			</TR>
			<cfoutput query="avail">
			<TR ALIGN="center">
				
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;"><strong>1:00AM</strong></TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;"><strong>1:30AM</strong></TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;"><strong>2:00AM</strong></TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;"><strong>2:30AM</strong></TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;"><strong>3:00AM</strong></TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;"><strong>3:30AM</strong></TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;"><strong>4:00AM</strong></TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;"><strong>4:30AM</strong></TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;"><strong>5:00AM</strong></TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF; border-right: solid 1px ##6699FF"><strong>5:30AM</strong></TD>
				
			</TR>
			<TR ALIGN="center">
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><cfif avail.x0100 EQ 1>A<cfelse><font color="##FF0000">NA<cfif avail.u_reason GT 0>*</cfif></font></cfif></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><cfif avail.x0150 EQ 1>A<cfelse><font color="##FF0000">NA<cfif avail.u_reason GT 0>*</cfif></font></cfif></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><cfif avail.x0200 EQ 1>A<cfelse><font color="##FF0000">NA<cfif avail.u_reason GT 0>*</cfif></font></cfif></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><cfif avail.x0250 EQ 1>A<cfelse><font color="##FF0000">NA<cfif avail.u_reason GT 0>*</cfif></font></cfif></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><cfif avail.x0300 EQ 1>A<cfelse><font color="##FF0000">NA<cfif avail.u_reason GT 0>*</cfif></font></cfif></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><cfif avail.x0350 EQ 1>A<cfelse><font color="##FF0000">NA<cfif avail.u_reason GT 0>*</cfif></font></cfif></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><cfif avail.x0400 EQ 1>A<cfelse><font color="##FF0000">NA<cfif avail.u_reason GT 0>*</cfif></font></cfif></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><cfif avail.x0450 EQ 1>A<cfelse><font color="##FF0000">NA<cfif avail.u_reason GT 0>*</cfif></font></cfif></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><cfif avail.x0500 EQ 1>A<cfelse><font color="##FF0000">NA<cfif avail.u_reason GT 0>*</cfif></font></cfif></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF; border-right: solid 1px ##6699FF"><cfif avail.x0550 EQ 1>A<cfelse><font color="##FF0000">NA<cfif avail.u_reason GT 0>*</cfif></font></cfif></TD>
			</TR>
			<tr><td style="border-left: solid 1px ##6699FF; border-right: solid 1px ##6699FF" class="header" colspan="10">&nbsp;</td></tr>
			<TR ALIGN="center">
				
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;"><strong>6:00AM</strong></TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;"><strong>6:30AM</strong></TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;"><strong>7:00AM</strong></TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;"><strong>7:30AM</strong></TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;"><strong>8:00AM</strong></TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;"><strong>8:30AM</strong></TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;"><strong>9:00AM</strong></TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;"><strong>9:30AM</strong></TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;"><strong>10:00AM</strong></TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF; border-right: solid 1px ##6699FF"><strong>10:30AM</strong></TD>
				
			</TR>
			<TR ALIGN="center">
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><cfif avail.x0600 EQ 1>A<cfelse><font color="##FF0000">NA<cfif avail.u_reason GT 0>*</cfif></font></cfif></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><cfif avail.x0650 EQ 1>A<cfelse><font color="##FF0000">NA<cfif avail.u_reason GT 0>*</cfif></font></cfif></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><cfif avail.x0700 EQ 1>A<cfelse><font color="##FF0000">NA<cfif avail.u_reason GT 0>*</cfif></font></cfif></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><cfif avail.x0750 EQ 1>A<cfelse><font color="##FF0000">NA<cfif avail.u_reason GT 0>*</cfif></font></cfif></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><cfif avail.x0800 EQ 1>A<cfelse><font color="##FF0000">NA<cfif avail.u_reason GT 0>*</cfif></font></cfif></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><cfif avail.x0850 EQ 1>A<cfelse><font color="##FF0000">NA<cfif avail.u_reason GT 0>*</cfif></font></cfif></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><cfif avail.x0900 EQ 1>A<cfelse><font color="##FF0000">NA<cfif avail.u_reason GT 0>*</cfif></font></cfif></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><cfif avail.x0950 EQ 1>A<cfelse><font color="##FF0000">NA<cfif avail.u_reason GT 0>*</cfif></font></cfif></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><cfif avail.x1000 EQ 1>A<cfelse><font color="##FF0000">NA<cfif avail.u_reason GT 0>*</cfif></font></cfif></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF; border-right: solid 1px ##6699FF"><cfif avail.x1050 EQ 1>A<cfelse><font color="##FF0000">NA<cfif avail.u_reason GT 0>*</cfif></font></cfif></TD>
			</TR>
			<tr><td style="border-left: solid 1px ##6699FF; border-right: solid 1px ##6699FF" class="header" colspan="10">&nbsp;</td></tr>
			<TR ALIGN="center">
				
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;"><strong>11:00AM</strong></TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;"><strong>11:30AM</strong></TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;"><strong>12:00PM</strong></TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;"><strong>12:30PM</strong></TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;"><strong>1:00PM</strong></TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;"><strong>1:30PM</strong></TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;"><strong>2:00PM</strong></TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;"><strong>2:30PM</strong></TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;"><strong>3:00PM</strong></TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF; border-right: solid 1px ##6699FF"><strong>3:30PM</strong></TD>

			</TR>
			<TR ALIGN="center">
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><cfif avail.x1100 EQ 1>A<cfelse><font color="##FF0000">NA<cfif avail.u_reason GT 0>*</cfif></font></cfif></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><cfif avail.x1150 EQ 1>A<cfelse><font color="##FF0000">NA<cfif avail.u_reason GT 0>*</cfif></font></cfif></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><cfif avail.x1200 EQ 1>A<cfelse><font color="##FF0000">NA<cfif avail.u_reason GT 0>*</cfif></font></cfif></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><cfif avail.x1250 EQ 1>A<cfelse><font color="##FF0000">NA<cfif avail.u_reason GT 0>*</cfif></font></cfif></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><cfif avail.x1300 EQ 1>A<cfelse><font color="##FF0000">NA<cfif avail.u_reason GT 0>*</cfif></font></cfif></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><cfif avail.x1350 EQ 1>A<cfelse><font color="##FF0000">NA<cfif avail.u_reason GT 0>*</cfif></font></cfif></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><cfif avail.x1400 EQ 1>A<cfelse><font color="##FF0000">NA<cfif avail.u_reason GT 0>*</cfif></font></cfif></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><cfif avail.x1450 EQ 1>A<cfelse><font color="##FF0000">NA<cfif avail.u_reason GT 0>*</cfif></font></cfif></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><cfif avail.x1500 EQ 1>A<cfelse><font color="##FF0000">NA<cfif avail.u_reason GT 0>*</cfif></font></cfif></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF; border-right: solid 1px ##6699FF"><cfif avail.x1550 EQ 1>A<cfelse><font color="##FF0000">NA<cfif avail.u_reason GT 0>*</cfif></font></cfif></TD>
			</TR>
			<tr><td style="border-left: solid 1px ##6699FF; border-right: solid 1px ##6699FF" class="header" colspan="10">&nbsp;</td></tr>
			<TR ALIGN="center">
				
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;"><strong>4:00PM</strong></TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;"><strong>4:30PM</strong></TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;"><strong>5:00PM</strong></TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;"><strong>5:30PM</strong></TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;"><strong>6:00PM</strong></TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;"><strong>6:30PM</strong></TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;"><strong>7:00PM</strong></TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;"><strong>7:30PM</strong></TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;"><strong>8:00PM</strong></TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF; border-right: solid 1px ##6699FF"><strong>8:30PM</strong></TD>

			</TR>
			<TR ALIGN="center">
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><cfif avail.x1600 EQ 1>A<cfelse><font color="##FF0000">NA<cfif avail.u_reason GT 0>*</cfif></font></cfif></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><cfif avail.x1650 EQ 1>A<cfelse><font color="##FF0000">NA<cfif avail.u_reason GT 0>*</cfif></font></cfif></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><cfif avail.x1700 EQ 1>A<cfelse><font color="##FF0000">NA<cfif avail.u_reason GT 0>*</cfif></font></cfif></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><cfif avail.x1750 EQ 1>A<cfelse><font color="##FF0000">NA<cfif avail.u_reason GT 0>*</cfif></font></cfif></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><cfif avail.x1800 EQ 1>A<cfelse><font color="##FF0000">NA<cfif avail.u_reason GT 0>*</cfif></font></cfif></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><cfif avail.x1850 EQ 1>A<cfelse><font color="##FF0000">NA<cfif avail.u_reason GT 0>*</cfif></font></cfif></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><cfif avail.x1900 EQ 1>A<cfelse><font color="##FF0000">NA<cfif avail.u_reason GT 0>*</cfif></font></cfif></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><cfif avail.x1950 EQ 1>A<cfelse><font color="##FF0000">NA<cfif avail.u_reason GT 0>*</cfif></font></cfif></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><cfif avail.x2000 EQ 1>A<cfelse><font color="##FF0000">NA<cfif avail.u_reason GT 0>*</cfif></font></cfif></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF; border-right: solid 1px ##6699FF"><cfif avail.x2050 EQ 1>A<cfelse><font color="##FF0000">NA</font></cfif></TD>
			</TR>
			<tr><td style="border-left: solid 1px ##6699FF; border-right: solid 1px ##6699FF" class="header" colspan="10">&nbsp;</td></tr>
			<TR ALIGN="center">
				
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;"><strong>9:00PM</strong></TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;"><strong>9:30PM</strong></TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;"><strong>10:00PM</strong></TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;"><strong>10:30PM</strong></TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;"><strong>11:00PM</strong></TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;"><strong>11:30PM</strong></TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;"><strong>12:00AM</strong></TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF; border-right: solid 1px ##6699FF"><strong>12:30PM</strong></TD>
				<TD class="header" style="border-right: solid 1px ##6699FF;" colspan="2">&nbsp;</TD>
			</TR>
			<TR ALIGN="center">
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><cfif avail.x2100 EQ 1>A<cfelse><font color="##FF0000">NA<cfif avail.u_reason GT 0>*</cfif></font></cfif></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><cfif avail.x2150 EQ 1>A<cfelse><font color="##FF0000">NA<cfif avail.u_reason GT 0>*</cfif></font></cfif></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><cfif avail.x2200 EQ 1>A<cfelse><font color="##FF0000">NA<cfif avail.u_reason GT 0>*</cfif></font></cfif></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><cfif avail.x2250 EQ 1>A<cfelse><font color="##FF0000">NA<cfif avail.u_reason GT 0>*</cfif></font></cfif></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><cfif avail.x2300 EQ 1>A<cfelse><font color="##FF0000">NA<cfif avail.u_reason GT 0>*</cfif></font></cfif></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><cfif avail.x2350 EQ 1>A<cfelse><font color="##FF0000">NA<cfif avail.u_reason GT 0>*</cfif></font></cfif></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><cfif avail.x2400 EQ 1>A<cfelse><font color="##FF0000">NA<cfif avail.u_reason GT 0>*</cfif></font></cfif></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF; border-right: solid 1px ##6699FF"><cfif avail.x0050 EQ 1>A<cfelse><font color="##FF0000">NA<cfif avail.u_reason GT 0>*</cfif></font></cfif></TD>
				<TD class="header" style="border-bottom: solid 1px ##6699FF; border-right: solid 1px ##6699FF" colspan="2">&nbsp;</TD>
			</TR>
			<cfif avail.u_reason GT 0>
			<tr>
				<td colspan="3"><strong>Reason Unavailable:</strong>&nbsp;&nbsp;#GetReason.description#</td>
				<td colspan="8">#avail.comments#</td>
			</tr>
			</cfif>
			
			</cfoutput>
			</table>
			<table cellspacing="0" cellpadding="1" WIDTH="550" HEIGHT="50">
			<tr><td colspan="4">&nbsp;</td></tr>
			<TR>	
					<TD COLSPAN="3" ALIGN="center">
						<CFOUTPUT>
						<form name="edit" action="schedule_time_edit.cfm?ID=#ID#&no_menu=1&day=#url.Day#&month=#url.month#&year=#url.year#" method="post">
						<INPUT TYPE="hidden" NAME="rowid" Value="#avail.rowid#">
						<input type="submit"  value="Edit Time" name="schedule_time_button">
						</form>
						</CFOUTPUT>
					</TD>
					<TD COLSPAN="3" ALIGN="center">
						<INPUT TYPe="button"  VALUE="   CANCEL   " NAME="" onclick="window.close()">
					</TD>
					<TD COLSPAN="2" ALIGN="center">
						<INPUT TYPE="button"  VALUE="Close and Refresh" ONCLICK="closeandrefresh()">
					</TD>			
			</TR>
			
		</TABLE>

		<center><a href="javascript:OpenWindow('schedule_help.htm#schedule_time_add')"><img src="../images/help.gif" border="0"></a></center>

	</BODY>
</form>
</HTML>