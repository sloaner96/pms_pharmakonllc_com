<!--------------------------------------------------------------------
-- roster_conf_roster2.cfm 
-- Ben Jurevicius - 06242003
--
-- Pulls roster data based on the dates entered in roster_conf_roster.cfm
--
-- This program has basic 2 steps:
-- 1) pull and tabluate all the data by meetingcode.
-- 2) generate conference company rosters for each meeting in CV format.
--
-----------------------------------------------------------------------
--->

<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Conference Company Rosters - Pull Data" showCalendar="0">

<SCRIPT SRC="/includes/libraries/PIW1checker.js"></SCRIPT>

<SCRIPT LANGUAGE="JavaScript">
<!-- Modified By:  Steve Robison, Jr. (stevejr@ce.net) -->

<!-- This script and many more are available free online at -->
<!-- The JavaScript Source!! http://javascript.internet.com -->

<!-- Begin
var checkflag = "false";
function check(field) {
if (checkflag == "false") {
for (i = 0; i < field.length; i++) {
field[i].checked = false;}
checkflag = "true";
return "Check All"; }
else {
for (i = 0; i < field.length; i++) {
field[i].checked = true; }
checkflag = "false";
return "Unheck All"; }
}
//  End -->
</script>		

<CFSWITCH EXPRESSION="#URL.a#">
<!--- Step #1 --->
<CFCASE VALUE="1">
	<!--- Pull appropriate row for the selected project code --->
	<CFQUERY DATASOURCE="#Application.RosterDSN#" NAME="q1">
		select meetingcode, apptdate, count(meetingcode) as cnt from roster
			where apptdate between '#form.begin_date#' and '#form.end_date#'
			group by meetingcode, apptdate	
			order by meetingcode, apptdate
	</CFQUERY>

	<FORM NAME="step1" ACTION="" METHOD="post">
	<table border="0">
	<cfoutput>
	<tr>
		<td width=50>&nbsp;</td>
		<td colspan=4><b>Invitees by meeting for dates: #form.begin_date# - #form.end_date#</b></td>		
	</tr>
	<tr>
		<td colspan="4">&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td colspan="4">&nbsp;</td>
		<td><input type=button value="Uncheck All" onClick="this.value=check(this.form.which)"></td>
	</tr>
	</cfoutput>
	<tr>
		<td width=50>&nbsp;</td>
		<td><b>Appt. Date</b></td>		
		<td><b>Meeting Code</b></td>
		<td><b>Invitees</b></td>
		<td><b>Upload? (checked Yes)</b></td>
	</tr>
	<cfset m_grand_tot = 0>
	<cfset a_grand_tot = 0>
	<cfoutput query="q1">
	<tr>
		<td width=50>&nbsp;</td>
		<td>#DateFormat(q1.apptdate, "mm/dd/yyyy")#</b></td>
		<td>#trim(q1.meetingcode)#</b></td>
		<td>#q1.cnt#</b></td>
		<!--- check box allows user to choose which files to create --->
		<td><input type="checkbox" name="which" value="#trim(q1.meetingcode)#" checked></td>
		<cfset m_grand_tot = m_grand_tot + 1>
		<cfset a_grand_tot = a_grand_tot + #q1.cnt#>
	</tr>
	</cfoutput>
	<cfoutput>
	<tr>
		<td width=50>&nbsp;</td>
		<td colspan=4 align=right><b>====================================</b></td>
	</tr>
	<tr>
		<td width=50>&nbsp;</td>
		<td align=right><b>Total </b></td>
		<td>#m_grand_tot# Meetings</b></td>
		<td align=center>#a_grand_tot# Invitees</b></td>
	</tr>
	</cfoutput>
	</table>
	
	<table>
	<cfoutput>
	<tr>
		<td width=50>&nbsp;</td>
		<TD ALIGN="right"><input TYPE="Button" NAME="run" VALUE="Create Conference Company Rosters" onClick="action = 'roster_conf_roster2.cfm?a=2&bd=#form.begin_date#&ed=#form.end_date#&#Rand()#'; submit();"></TD>
		<td align="right"><input TYPE="Button" NAME="cancel" VALUE="Cancel" onClick="action = 'roster_conf_roster.cfm'; submit();"></td>
	</tr>
	</cfoutput>
	<tr height=20><td colspan=3>&nbsp;</td></tr>
	</table>
	</form>
</CFCASE>
<!--- step #2 --->
<CFCASE VALUE="2">
	<FORM NAME="step2" ACTION="roster_certificates2.cfm?a=3&#Rand()#" METHOD="post">
	<table>
	<tr>
		<td width=50>&nbsp;</td>
		<td colspan=2 align=center><h5><font color="green">Creating conference company rosters, please wait... </font></h5><br><br></td>
	</tr>
	<tr height=20><td colspan=3>&nbsp;</td></tr>
	</table>
	<!--- <cfoutput>#form.which#</cfoutput><cfabort> --->
	<!--- <cfoutput><input type="hidden" name="which" value="#form.which#"></cfoutput> --->
	</form>
	</body>
	<cfoutput>
	<META HTTP-EQUIV="refresh" CONTENT="3; URL=roster_conf_roster2.cfm?a=3&bd=#url.bd#&ed=#url.ed#&which=#form.which#&#Rand()#">
	</cfoutput>


</cfcase>
<!--- step #3 --->
<CFCASE VALUE="3">
		<!--- <cfoutput>Step 3:#url.which#</cfoutput><cfabort> --->
	<!--- Pull invitees by meeting code: meeting codes are passed in a url list --->
	<CFQUERY DATASOURCE="#Application.RosterDSN#" NAME="q3">
		select phid, meetingcode, apptdate, appttime, lastname, firstname, cet_phone, office_phone, moderator, prime_specialty
		from roster
		where <!--- apptdate between '#URL.bd#' and '#URL.ed#'  --->meetingcode IN (#ListQualify(url.which,"'")#)
		order by apptdate, meetingcode, lastname, firstname
	</CFQUERY>

	<!--- set up some variables --->
	<cfset m_grand_tot = 0>
	<cfset a_grand_tot = 0>
	<cfset fname = "">
		<!--- use this link for Mozart --->
	<!--- <cfset fpath = "C:\Users Shared Folders\ConferenceRosters\TEST\"> --->
	<cfset fpath = "C:\Users Shared Folders\ConferenceRosters\">
	<cfset sDate = "#dateFormat(Now(), 'yyyymmdd')#">
	<cfset ThisMeeting = "">
	<cfset LastMeeting = "">
	<cfoutput query="q3">	
		<cfset ThisMeeting = #trim(q3.meetingcode)#>
		<cfif ThisMeeting EQ #LastMeeting#>
			<cffile action="append" file="#fname#" nameconflict="overwrite" 
				output="#trim(q3.Phid)#,#trim(q3.meetingcode)#,#dateFormat(q3.apptdate, 'mm/dd/yyyy')#,#trim(q3.appttime)#,#trim(q3.lastname)#,#trim(q3.firstname)#,#trim(q3.prime_specialty)#,#trim(q3.cet_phone)#,#trim(q3.office_phone)#,#ucase(trim(q3.moderator))#">
		<cfelse>
			<cfset LastMeeting = #ThisMeeting#>
			<cfset fname = #fpath# & #trim(ThisMeeting)# & ".csv">
			<cfset m_grand_tot = m_grand_tot + 1>
			<cffile action="write" file="#fname#" nameconflict="overwrite" 
				output="PERSONALID, MEETING CODE,DATE,TIME,LAST NAME,FIRST NAME,SPECIALTY,CET PHONE,OFFICE PHONE,MODERATOR"> 
			<cffile action="append" file="#fname#" nameconflict="overwrite" 
				output="#trim(q3.Phid)#,#trim(q3.meetingcode)#,#dateFormat(q3.apptdate, 'mm/dd/yyyy')#,#trim(q3.appttime)#,#trim(q3.lastname)#,#trim(q3.firstname)#,#trim(q3.prime_specialty)#,#trim(q3.cet_phone)#,#trim(q3.office_phone)#,#ucase(trim(q3.moderator))#">
		</cfif>
		<!--- increment invitee count --->
		<cfset a_grand_tot = a_grand_tot + 1>
	</cfoutput>
	<FORM NAME="step3" ACTION="" METHOD="post">
	<cfoutput>
	<table>
	<tr>
		<td width=50>&nbsp;</td>
		<TD colspan=2><h4><font color="green">Processing Complete!</font></h4></TD>
	</tr>
	<tr>
		<td width=50>&nbsp;</td>
		<TD colspan=2>Output files are located in <B>#fpath#</B> and are named by meeting code prefix and today's date.</b></TD>
	</tr>
	<tr>
		<td width=50>&nbsp;</td>
		<td colspan=2><b>Total Invitees: #a_grand_tot#</b></td>
	</tr>
	<tr>
		<td width=50>&nbsp;</td>
		<td colspan=2><b>Total Files: #m_grand_tot#</b></td>
	</tr>
	<tr height=20><td colspan=3>&nbsp;</td></tr>
	<tr>
		<td width=50>&nbsp;</td>
		<TD ALIGN="center"><input TYPE="Button" NAME="finish" VALUE="Finished" onClick="action = 'roster_conf_roster.cfm?&#Rand()#'; submit();"></TD>
	</tr>
	<tr height=20><td colspan=3>&nbsp;</td></tr>
	</table>
	</cfoutput>
	</form>
</cfcase>
		
<!--- If no case is specified user is sent a processing error --->
<CFDEFAULTCASE>
	<cfoutput>
	<FORM NAME="cert2" ACTION="" METHOD="post">
	</cfoutput>
	<table>
	<tr>
		<td width=50>&nbsp;</td>
		<td colspan=3><h4><font color=red>A processing error has occurred!  Please try again...</font></h4></td>
	</tr>
	<tr height=20><td colspan=3>&nbsp;</td></tr>
	<tr>
		<td width=50>&nbsp;</td>
		<TD ALIGN="right"><input TYPE="Button" NAME="tryagain" VALUE="Try Again" onClick="action = 'roster_conf_roster.cfm'; submit();"></TD>
		<td>&nbsp;</td>
	</tr>
	<tr height=50><td colspan=3>&nbsp;</td></tr>
	</table>
	</form>
</CFDEFAULTCASE>
</CFSWITCH>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">

