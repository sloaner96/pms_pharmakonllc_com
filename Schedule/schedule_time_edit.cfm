<!--- 
	*****************************************************************************************
	Name:		schedule_time_edit.cfm
	Function:	Edit available time for speaker or moderator. Has check boxes - checked is available, 
				unchecked is unavailable

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
			
<!--
// marks all time available
function check_all() 
{
	if (thisdoc.x0100.disabled == false){
		thisdoc.x0100.checked = true;
	}
	if (thisdoc.x0150.disabled == false){
		thisdoc.x0150.checked = true;
	}
	if (thisdoc.x0200.disabled == false){
		thisdoc.x0200.checked = true;
	}
	if (thisdoc.x0250.disabled == false){
		thisdoc.x0250.checked = true;
	}
	if (thisdoc.x0300.disabled == false){
		thisdoc.x0300.checked = true;
	}
	if (thisdoc.x0350.disabled == false){
		thisdoc.x0350.checked = true;
	}
	if (thisdoc.x0400.disabled == false){
		thisdoc.x0400.checked = true;
	}
	if (thisdoc.x0450.disabled == false){
		thisdoc.x0450.checked = true;
	}
	if (thisdoc.x0500.disabled == false){
		thisdoc.x0500.checked = true;
	}
	if (thisdoc.x0550.disabled == false){
		thisdoc.x0550.checked = true;
	}
	if (thisdoc.x0600.disabled == false){
		thisdoc.x0600.checked = true;
	}
	if (thisdoc.x0650.disabled == false){
		thisdoc.x0650.checked = true;
	}
	if (thisdoc.x0700.disabled == false){
		thisdoc.x0700.checked = true;
	}
	if (thisdoc.x0750.disabled == false){
		thisdoc.x0750.checked = true;
	}
	if (thisdoc.x0800.disabled == false){
		thisdoc.x0800.checked = true;
	}
	if (thisdoc.x0850.disabled == false){
		thisdoc.x0850.checked = true;
	}
	if (thisdoc.x0900.disabled == false){
		thisdoc.x0900.checked = true;
	}
	if (thisdoc.x0950.disabled == false){
		thisdoc.x0950.checked = true;
	}
	if (thisdoc.x1000.disabled == false){
		thisdoc.x1000.checked = true;
	}
	if (thisdoc.x1050.disabled == false){
		thisdoc.x1050.checked = true;
	}
	if (thisdoc.x1100.disabled == false){
		thisdoc.x1100.checked = true;
	}
	if (thisdoc.x1150.disabled == false){
		thisdoc.x1150.checked = true;
	}
	if (thisdoc.x1200.disabled == false){
		thisdoc.x1200.checked = true;
	}
	if (thisdoc.x1250.disabled == false){
		thisdoc.x1250.checked = true;
	}
	if (thisdoc.x1300.disabled == false){
		thisdoc.x1300.checked = true;
	}
	if (thisdoc.x1350.disabled == false){
		thisdoc.x1350.checked = true;
	}
	if (thisdoc.x1400.disabled == false){
		thisdoc.x1400.checked = true;
	}
	if (thisdoc.x1450.disabled == false){
		thisdoc.x1450.checked = true;
	}
	if (thisdoc.x1500.disabled == false){
		thisdoc.x1500.checked = true;
	}
	if (thisdoc.x1550.disabled == false){
		thisdoc.x1550.checked = true;
	}
	if (thisdoc.x1600.disabled == false){
		thisdoc.x1600.checked = true;
	}
	if (thisdoc.x1650.disabled == false){
		thisdoc.x1650.checked = true;
	}
	if (thisdoc.x1700.disabled == false){
		thisdoc.x1700.checked = true;
	}
	if (thisdoc.x1750.disabled == false){
		thisdoc.x1750.checked = true;
	}
	if (thisdoc.x1800.disabled == false){
		thisdoc.x1800.checked = true;
	}
	if (thisdoc.x1850.disabled == false){
		thisdoc.x1850.checked = true;
	}
	if (thisdoc.x1900.disabled == false){
		thisdoc.x1900.checked = true;
	}
	if (thisdoc.x1950.disabled == false){
		thisdoc.x1950.checked = true;
	}
	if (thisdoc.x2000.disabled == false){
		thisdoc.x2000.checked = true;
	}
	if (thisdoc.x2050.disabled == false){
		thisdoc.x2050.checked = true;
	}
	if (thisdoc.x2100.disabled == false){
		thisdoc.x2100.checked = true;
	}
	if (thisdoc.x2150.disabled == false){
		thisdoc.x2150.checked = true;
	}
	if (thisdoc.x2200.disabled == false){
		thisdoc.x2200.checked = true;
	}
	if (thisdoc.x2250.disabled == false){
		thisdoc.x2250.checked = true;
	}
	if (thisdoc.x2300.disabled == false){
		thisdoc.x2300.checked = true;
	}
	if (thisdoc.x2350.disabled == false){
		thisdoc.x2350.checked = true;
	}
	if (thisdoc.x2400.disabled == false){
		thisdoc.x2400.checked = true;
	}
	if (thisdoc.x0050.disabled == false){
		thisdoc.x0050.checked = true;
	}
	
}
// marks all time unavailable
function uncheck_all() 
{
	thisdoc.x0100.checked = false;
	thisdoc.x0150.checked = false;
	thisdoc.x0200.checked = false;
	thisdoc.x0250.checked = false;
	thisdoc.x0300.checked = false;
	thisdoc.x0350.checked = false;
	thisdoc.x0400.checked = false;
	thisdoc.x0450.checked = false;
	thisdoc.x0500.checked = false;
	thisdoc.x0550.checked = false;
	thisdoc.x0600.checked = false;
	thisdoc.x0650.checked = false;
	thisdoc.x0700.checked = false;
	thisdoc.x0750.checked = false;
	thisdoc.x0800.checked = false;
	thisdoc.x0850.checked = false;
	thisdoc.x0900.checked = false;
	thisdoc.x0950.checked = false;
	thisdoc.x1000.checked = false;
	thisdoc.x1050.checked = false;
	thisdoc.x1100.checked = false;
	thisdoc.x1150.checked = false;
	thisdoc.x1200.checked = false;
	thisdoc.x1250.checked = false;
	thisdoc.x1300.checked = false;
	thisdoc.x1350.checked = false;
	thisdoc.x1400.checked = false;
	thisdoc.x1450.checked = false;
	thisdoc.x1500.checked = false;
	thisdoc.x1550.checked = false;
	thisdoc.x1600.checked = false;
	thisdoc.x1650.checked = false;
	thisdoc.x1700.checked = false;
	thisdoc.x1750.checked = false;
	thisdoc.x1800.checked = false;
	thisdoc.x1850.checked = false;
	thisdoc.x1900.checked = false;
	thisdoc.x1950.checked = false;
	thisdoc.x2000.checked = false;
	thisdoc.x2050.checked = false;
	thisdoc.x2100.checked = false;
	thisdoc.x2150.checked = false;
	thisdoc.x2200.checked = false;
	thisdoc.x2250.checked = false;
	thisdoc.x2300.checked = false;
	thisdoc.x2350.checked = false;
	thisdoc.x2400.checked = false;
	thisdoc.x0050.checked = false;
}

//if all time is marked available, set form.allday to 1, default is 2 - partial
function check_allday() 
{
	if (thisdoc.x0600.checked == true && thisdoc.x0650.checked == true &&
	 thisdoc.x0700.checked == true && thisdoc.x0750.checked == true &&
	 thisdoc.x0800.checked == true && thisdoc.x0850.checked == true &&
	thisdoc.x0900.checked == true && thisdoc.x0950.checked == true &&
	thisdoc.x1000.checked == true && thisdoc.x1050.checked == true &&
	thisdoc.x1100.checked == true && thisdoc.x1150.checked == true &&
	thisdoc.x1200.checked == true && thisdoc.x1250.checked == true &&
	thisdoc.x1300.checked == true && thisdoc.x1350.checked == true &&
	thisdoc.x1400.checked == true && thisdoc.x1450.checked == true &&
	thisdoc.x1500.checked == true && thisdoc.x1550.checked == true &&
	thisdoc.x1600.checked == true &&	thisdoc.x1650.checked == true &&
	thisdoc.x1700.checked == true && thisdoc.x1750.checked == true &&
	thisdoc.x1800.checked == true && thisdoc.x1850.checked == true &&
	thisdoc.x1900.checked == true &&	thisdoc.x1950.checked == true &&
	thisdoc.x2000.checked == true &&	thisdoc.x2050.checked == true &&
	thisdoc.x2100.checked == true &&	thisdoc.x2150.checked == true &&
	thisdoc.x2200.checked == true &&	thisdoc.x2250.checked == true &&
	thisdoc.x2300.checked == true) 
	 
	{
	thisdoc.allday.value = 1;
	}
	
	//if all time is marked unavailable, set form.allday to 0, default is 2 - partial
	if (thisdoc.x0600.checked == false && thisdoc.x0650.checked == false &&
	 thisdoc.x0700.checked == false && thisdoc.x0750.checked == false &&
	 thisdoc.x0800.checked == false && thisdoc.x0850.checked == false &&
	thisdoc.x0900.checked == false && thisdoc.x0950.checked == false &&
	thisdoc.x1000.checked == false && thisdoc.x1050.checked == false &&
	thisdoc.x1100.checked == false && thisdoc.x1150.checked == false &&
	thisdoc.x1200.checked == false && thisdoc.x1250.checked == false &&
	thisdoc.x1300.checked == false && thisdoc.x1350.checked == false &&
	thisdoc.x1400.checked == false && thisdoc.x1450.checked == false &&
	thisdoc.x1500.checked == false && thisdoc.x1550.checked == false &&
	thisdoc.x1600.checked == false &&	thisdoc.x1650.checked == false &&
	thisdoc.x1700.checked == false && thisdoc.x1750.checked == false &&
	thisdoc.x1800.checked == false && thisdoc.x1850.checked == false &&
	thisdoc.x1900.checked == false &&	thisdoc.x1950.checked == false &&
	thisdoc.x2000.checked == false &&	thisdoc.x2050.checked == false &&
	thisdoc.x2100.checked == false &&	thisdoc.x2150.checked == false &&
	thisdoc.x2200.checked == false &&	thisdoc.x2250.checked == false &&
	thisdoc.x2300.checked == false) 
	 
	{
	thisdoc.allday.value = 0;
	}
}

		</SCRIPT>
	</HEAD>
	<BODY>


	<CFSET year = URL.year>
	<CFSET month = URL.month>
	<CFSET day = URL.day>	
		
		
	
	<!--- Pull times for this speaker/mod --->
	<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="avail">
		SELECT *
		FROM availability_time
		WHERE rowid = #form.rowid#
	</CFQUERY>
	
	<cfif avail.recordcount>
		<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="getReason">
			SELECT code, description
			FROM codes
			WHERE code_type = 'UREAS'
		</CFQUERY>
	</cfif>
	
	<!--- this method checks to see if the mod/speaker has any meetings scheduled for this day. If so, keep those times
are marked unavailable --->
	<cfinvoke
		component="pms.com.cfc_checkdates" 
		method="PullUnavailable" 
		savemonth="#url.month#"
		saveyear="#url.year#"
		saveday="#url.day#"
		id="#url.ID#"
		today="#createodbcdate(Now())#"
		userid="#session.userinfo.rowid#"
		returnVariable="aMeetings"
	>			
			
		<cfloop from="1" to="#ArrayLen(aMeetings)#" index="x" step="1">
			<cfoutput>
			<cfset "a#Evaluate(aMeetings[x][3])#" = 0>
			<!--- <CFSet "request.FixInfo.#qGetOpts.OptionName#" = OptInfo.ChStatus> --->
			</cfoutput>
			</cfloop>
			<!--- <cfoutput>
			1300-#a1300#<br>
			1350-#a1350#<br>
			1400-#a1400#<br>
			1800-#a1800#<br>
			1850-#a1850#<br>
			</cfoutput> --->
	
<cfoutput>
<form name="thisdoc" onSubmit="check_allday()" action="schedule_time_edit2.cfm?ID=#ID#&no_menu=1&day=#Day#&month=#month#&year=#year#" method="post"></cfoutput>
	<!--- Display times and if available or not --->
	<table border="0" cellspacing="0" cellpadding="2" WIDTH="550" HEIGHT="50">
			<TR ALIGN="center">
				<Th style="border-left: solid 1px #6699FF; border-top: solid 1px #6699FF; border-right: solid 1px #6699FF;" bgcolor="#99CCFF" colspan="10">Times Available<br>
				</Th>
			</TR>
			<tr>
				<td style="border-left: solid 1px #6699FF; border-right: solid 1px #6699FF;" colspan="10"><font color="#3399FF"><strong>Please check the box if time is available. Uncheck the box if unavailable. 
				Times that a moderator or speaker has meetings scheduled will be uneditable.</strong></font></td>
			</tr>
			<TR ALIGN="center">
				<TD style="border-right: solid 1px #6699FF; border-left: solid 1px #6699FF; border-top: solid 1px #6699FF;" class="header" colspan="10">&nbsp;</TD>
			</TR>
			<cfoutput query="avail">
						<TR ALIGN="center">
				
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">1:00AM</TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">1:30AM</TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">2:00AM</TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">2:30AM</TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">3:00AM</TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">3:30AM</TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">4:00AM</TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">4:30AM</TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">5:00AM</TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF; border-right: solid 1px ##6699FF">5:30AM</TD>
				
			</TR>
			<TR ALIGN="center">
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><input type="checkbox" name="x0100" value="1" <cfif avail.x0600 EQ 1>checked</cfif><cfif IsDefined("a0600")>disabled </cfif>></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><input type="checkbox" name="x0150" value="1" <cfif avail.x0650 EQ 1>checked</cfif><cfif IsDefined("a0650")>disabled </cfif>></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><input type="checkbox" name="x0200" value="1" <cfif avail.x0700 EQ 1>checked</cfif><cfif IsDefined("a0700")>disabled </cfif>></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><input type="checkbox" name="x0250" value="1" <cfif avail.x0750 EQ 1>checked</cfif><cfif IsDefined("a0750")>disabled </cfif>></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><input type="checkbox" name="x0300" value="1" <cfif avail.x0800 EQ 1>checked</cfif><cfif IsDefined("a0800")>disabled </cfif>></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><input type="checkbox" name="x0350" value="1" <cfif avail.x0850 EQ 1>checked</cfif><cfif IsDefined("a0850")>disabled </cfif>></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><input type="checkbox" name="x0400" value="1" <cfif avail.x0900 EQ 1>checked</cfif><cfif IsDefined("a0900")>disabled </cfif>></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><input type="checkbox" name="x0450" value="1" <cfif avail.x0950 EQ 1>checked</cfif><cfif IsDefined("a0950")>disabled </cfif>></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><input type="checkbox" name="x0500" value="1" <cfif avail.x1000 EQ 1>checked</cfif><cfif IsDefined("a1000")>disabled </cfif>></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF; border-right: solid 1px ##6699FF;"><input type="checkbox" name="x0550" value="1" <cfif avail.x1050 EQ 1>checked</cfif><cfif IsDefined("a1050")>disabled </cfif>></TD>
			</TR>
			<tr><td style="border-right: solid 1px ##6699FF; border-left: solid 1px ##6699FF;" class="header" colspan="10">&nbsp;</td></tr>
			<TR ALIGN="center">
			
			<TR ALIGN="center">
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">6:00AM</TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">6:30AM</TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">7:00AM</TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">7:30AM</TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">8:00AM</TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">8:30AM</TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">9:00AM</TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">9:30AM</TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">10:00AM</TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF; border-right: solid 1px ##6699FF;">10:30AM</TD>
			</TR>
			<TR ALIGN="center">
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><input type="checkbox" name="x0600" value="1" <cfif avail.x0600 EQ 1>checked</cfif><cfif IsDefined("a0600")>disabled </cfif>></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><input type="checkbox" name="x0650" value="1" <cfif avail.x0650 EQ 1>checked</cfif><cfif IsDefined("a0650")>disabled </cfif>></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><input type="checkbox" name="x0700" value="1" <cfif avail.x0700 EQ 1>checked</cfif><cfif IsDefined("a0700")>disabled </cfif>></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><input type="checkbox" name="x0750" value="1" <cfif avail.x0750 EQ 1>checked</cfif><cfif IsDefined("a0750")>disabled </cfif>></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><input type="checkbox" name="x0800" value="1" <cfif avail.x0800 EQ 1>checked</cfif><cfif IsDefined("a0800")>disabled </cfif>></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><input type="checkbox" name="x0850" value="1" <cfif avail.x0850 EQ 1>checked</cfif><cfif IsDefined("a0850")>disabled </cfif>></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><input type="checkbox" name="x0900" value="1" <cfif avail.x0900 EQ 1>checked</cfif><cfif IsDefined("a0900")>disabled </cfif>></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><input type="checkbox" name="x0950" value="1" <cfif avail.x0950 EQ 1>checked</cfif><cfif IsDefined("a0950")>disabled </cfif>></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><input type="checkbox" name="x1000" value="1" <cfif avail.x1000 EQ 1>checked</cfif><cfif IsDefined("a1000")>disabled </cfif>></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF; border-right: solid 1px ##6699FF;"><input type="checkbox" name="x1050" value="1" <cfif avail.x1050 EQ 1>checked</cfif><cfif IsDefined("a1050")>disabled </cfif>></TD>
			</TR>
			<tr><td style="border-right: solid 1px ##6699FF; border-left: solid 1px ##6699FF;" class="header" colspan="10">&nbsp;</td></tr>
			<TR ALIGN="center">
				
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">11:00AM</TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">11:30AM</TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">12:00PM</TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">12:30PM</TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">1:00PM</TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">1:30PM</TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">2:00PM</TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">2:30PM</TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">3:00PM</TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF; border-right: solid 1px ##6699FF;">3:30PM</TD>
				
			</TR>
			<TR ALIGN="center">
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><input type="checkbox" name="x1100" value="1" <cfif avail.x1100 EQ 1>checked</cfif><cfif IsDefined("a1100")>disabled </cfif>></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><input type="checkbox" name="x1150" value="1" <cfif avail.x1150 EQ 1>checked</cfif><cfif IsDefined("a1150")>disabled </cfif>></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><input type="checkbox" name="x1200" value="1" <cfif avail.x1200 EQ 1>checked</cfif><cfif IsDefined("a1200")>disabled </cfif>></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><input type="checkbox" name="x1250" value="1" <cfif avail.x1250 EQ 1>checked</cfif><cfif IsDefined("a1250")>disabled </cfif>></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><input type="checkbox" name="x1300" value="1" <cfif avail.x1300 EQ 1>checked</cfif><cfif IsDefined("a1300")>disabled </cfif>></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><input type="checkbox" name="x1350" value="1" <cfif avail.x1350 EQ 1>checked</cfif><cfif IsDefined("a1350")>disabled </cfif>></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><input type="checkbox" name="x1400" value="1" <cfif avail.x1400 EQ 1>checked</cfif><cfif IsDefined("a1400")>disabled </cfif>></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><input type="checkbox" name="x1450" value="1" <cfif avail.x1450 EQ 1>checked</cfif><cfif IsDefined("a1450")>disabled </cfif>></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><input type="checkbox" name="x1500" value="1" <cfif avail.x1500 EQ 1>checked</cfif><cfif IsDefined("a1500")>disabled </cfif>></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF; border-right: solid 1px ##6699FF;"><input type="checkbox" name="x1550" value="1" <cfif avail.x1550 EQ 1>checked</cfif><cfif IsDefined("a1550")>disabled </cfif>></TD>
			</TR>
			<tr><td style="border-right: solid 1px ##6699FF; border-left: solid 1px ##6699FF;" class="header" colspan="10">&nbsp;</td></tr>
			<TR ALIGN="center">
				
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">4:00PM</TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">4:30PM</TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">5:00PM</TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">5:30PM</TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">6:00PM</TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">6:30PM</TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">7:00PM</TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">7:30PM</TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">8:00PM</TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF; border-right: solid 1px ##6699FF;">8:30PM</TD>
				
			</TR>
			<TR ALIGN="center">
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><input type="checkbox" name="x1600" value="1" <cfif avail.x1600 EQ 1>checked</cfif><cfif IsDefined("a1600")>disabled </cfif>></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><input type="checkbox" name="x1650" value="1" <cfif avail.x1650 EQ 1>checked</cfif><cfif IsDefined("a1650")>disabled </cfif>></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><input type="checkbox" name="x1700" value="1" <cfif avail.x1700 EQ 1>checked</cfif><cfif IsDefined("a1700")>disabled </cfif>></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><input type="checkbox" name="x1750" value="1" <cfif avail.x1750 EQ 1>checked</cfif><cfif IsDefined("a1750")>disabled </cfif>></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><input type="checkbox" name="x1800" value="1" <cfif avail.x1800 EQ 1>checked</cfif><cfif IsDefined("a1800")>disabled </cfif>></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><input type="checkbox" name="x1850" value="1" <cfif avail.x1850 EQ 1>checked</cfif><cfif IsDefined("a1850")>disabled </cfif>></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><input type="checkbox" name="x1900" value="1" <cfif avail.x1900 EQ 1>checked</cfif><cfif IsDefined("a1900")>disabled </cfif>></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><input type="checkbox" name="x1950" value="1" <cfif avail.x1950 EQ 1>checked</cfif><cfif IsDefined("a1950")>disabled </cfif>></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><input type="checkbox" name="x2000" value="1" <cfif avail.x2000 EQ 1>checked</cfif><cfif IsDefined("a2000")>disabled </cfif>></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF; border-right: solid 1px ##6699FF;"><input type="checkbox" name="x2050" value="1" <cfif avail.x2050 EQ 1>checked</cfif><cfif IsDefined("a2050")>disabled </cfif>></TD>
			</TR>
			<tr><td style="border-right: solid 1px ##6699FF; border-left: solid 1px ##6699FF;" class="header" colspan="10">&nbsp;</td></tr>
			<TR ALIGN="center">
				
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">9:00PM</TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">9:30PM</TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">10:00PM</TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">10:30PM</TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">11:00PM</TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">11:30PM</TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF;">12:00AM</TD>
				<TD style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF; border-right: solid 1px ##6699FF;">12:30AM</TD>
				<TD valign="bottom" style="border-top: solid 1px ##6699FF; border-right: solid 1px ##6699FF;" colspan="2"><img src="images/check1.gif" name="check">&nbsp;<A href="##" onclick="javascript: check_all();">Check All Times</a></TD>
			</TR>
			<TR ALIGN="center">
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><input type="checkbox" name="x2100" value="1" <cfif avail.x2100 EQ 1>checked</cfif><cfif IsDefined("a2100")>disabled </cfif>></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><input type="checkbox" name="x2150" value="1" <cfif avail.x2150 EQ 1>checked</cfif><cfif IsDefined("a2150")>disabled </cfif>></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><input type="checkbox" name="x2200" value="1" <cfif avail.x2200 EQ 1>checked</cfif><cfif IsDefined("a2200")>disabled </cfif>></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><input type="checkbox" name="x2250" value="1" <cfif avail.x2250 EQ 1>checked</cfif><cfif IsDefined("a2250")>disabled </cfif>></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><input type="checkbox" name="x2300" value="1" <cfif avail.x2300 EQ 1>checked</cfif><cfif IsDefined("a2300")>disabled </cfif>></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><input type="checkbox" name="x2350" value="1" <cfif avail.x2350 EQ 1>checked</cfif><cfif IsDefined("a2350")>disabled </cfif>></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;"><input type="checkbox" name="x2400" value="1" <cfif avail.x2400 EQ 1>checked</cfif><cfif IsDefined("a2400")>disabled </cfif>></TD>
				<TD style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF; border-right: solid 1px ##6699FF;"><input type="checkbox" name="x0050" value="1" <cfif avail.x0050 EQ 1>checked</cfif><cfif IsDefined("a0050")>disabled </cfif>></TD>
				<TD style="border-bottom: solid 1px ##6699FF; border-right: solid 1px ##6699FF;" colspan="2">
				&nbsp;&nbsp;&nbsp;<img src="images/check_none.gif" name="uncheck">&nbsp;<A href="##" onclick="javascript: uncheck_all();">Uncheck All Times</a></TD>
				<!--- 2 = partial availability, 1 = full day availability, 0 = unavailable --->
				<input type="hidden" name="allday" value="2">
			</TR>
				<INPUT TYPE="hidden" NAME="rowid" Value="#form.rowid#">
			
			</cfoutput>

			<tr>
				<td style="border-bottom: solid 1px #6699FF; border-left: solid 1px #6699FF;" colspan="4"><strong>Reason<br>Unavailable:</strong>&nbsp;&nbsp;
					<select name="u_reason">
						<option value="0">(Select Reason)</option>
						<cfoutput query="GetReason">
						<option value="#GetReason.code#" <cfif GetReason.code EQ avail.u_reason>selected</cfif>>#GetReason.description#</option>
						</cfoutput>
					</select></td>
				<td style="border-bottom: solid 1px #6699FF; border-right: solid 1px #6699FF;" colspan="7"><strong>Comments:</strong>&nbsp;
					<cfoutput><textarea name="comments" cols="40" rows="3">#avail.comments#</textarea></cfoutput>
				</td>
			</tr>

			
			</table>
			<table cellspacing="0" cellpadding="1" WIDTH="550">
			<tr><td colspan="4">&nbsp;</td></tr>
			<TR>	
				<TD COLSPAN="4" ALIGN="center" valign="top">
						<CFOUTPUT>
						<input type="submit"  value="Edit Time and Refresh" name="schedule_time_button">
						</CFOUTPUT>
				</TD>
				<TD COLSPAN="4" ALIGN="center" valign="top">
						<INPUT TYPe="button"  VALUE="   CANCEL   " NAME="" onclick="window.close()">
				</TD>
					
			</TR>
			
		</TABLE>
			</form>
		<center><a href="javascript:OpenWindow('schedule_help.htm#schedule_time_edit')"><img src="../images/help.gif" border="0"></a></center>

		
	</BODY>

</HTML>