<!--------------------------------------------------------------------
-- roster_close_roster.cfm
-- Ben Jurevicius - 06252003
--
-- Changes meeting status to closed or cancelled.
--
-- This program has basic 2 steps:
-- 1) pull and tabluate all the data by meetingcode.
-- 2) change meeting status
--
-----------------------------------------------------------------------
--->
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Change Meeting Status" showCalendar="0">

<SCRIPT SRC="/includes/libraries/PIW1checker.js">
</SCRIPT>



<cfset ary_meetings = ArrayNew(1)>
<CFSWITCH EXPRESSION="#URL.a#">
<!--- Step #1 --->
<CFCASE VALUE="1">

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
return "Uncheck All"; }
}
//  End -->
</script>



	<!--- Pull appropriate row for the selected project code --->
	<CFQUERY DATASOURCE="#application.rosterDSN#"  NAME="q1">
		select distinct(meetingcode), apptdate from roster
			where closed = -1
			order by meetingcode, apptdate
	</CFQUERY>
	<body>
	<FORM NAME="step1" ACTION="" METHOD="post">
	<table border="0" align="center" cellpadding="3" cellspacing="1">
	<tr>
		<td width=50>&nbsp;
		<td colspan=2>Select the appropriate status<br> and check the box next to the meeting(s) you wish to close/cancel.</td>
	</tr>
	<tr>
		<td width=50>&nbsp;</td>
		<td width=150><b>Appt. Date</b></td>
		<td width=150><b>Meeting Code</b></td>
	</tr>
	<cfset m_grand_tot = 0>
	<cfoutput query="q1">
		<tr <cfif q1.currentrow MOD(2) EQ 1>bgcolor="##eeeeee"</cfif>>
			<td align=right width=50><input type="checkbox" value="#trim(q1.meetingcode)#" name="mcode" checked></td>
			<td>#DateFormat(q1.apptdate, "mm/dd/yyyy")#</td>
			<td><b>#trim(q1.meetingcode)#</b></td>
			<cfset m_grand_tot = m_grand_tot + 1>
		</tr>
	</cfoutput>
	<cfoutput>
	<tr>
		<td width=50>&nbsp;</td>
		<td colspan=2><b>===========================================</b></td>
	</tr>
	<tr>
		<td width=50>&nbsp;</td>
		<td>&nbsp;</td>
		<td><b>#m_grand_tot# Meetings</b></td>
	</tr>
		<tr>
				<td colspan=3 align="center"><br><input type=button value="Uncheck All" onClick="this.value=check(this.form.mcode)"></td>
	</tr>
	</cfoutput>
	<tr height=10><td colspan=2>&nbsp;</td></tr>
	<tr>
		<td width=50>&nbsp;</td>
		<td><input type="radio" name="status" value="0" checked>Close Meetings</td>
		<td><input type="radio" name="status" value="1">Cancel Meetings</td>
	</tr>
	<tr height=10><td colspan=3>&nbsp;</td></tr>
	<cfoutput>
	<tr>
		<td width=50>&nbsp;</td>
		<TD colspan=2><input TYPE="Button"  NAME="run" VALUE=" Update Meeting Status" onClick="action = 'roster_close_roster.cfm?a=2&#Rand()#'; submit();"></TD>
	</tr>
	</cfoutput>
	<tr height=20><td colspan=3>&nbsp;</td></tr>
	</table>
	</form>

</CFCASE>
<!--- step #2 --->
<CFCASE VALUE="2">
	<cfset mlist = "">
	<cfif isDefined("form.mcode")>
		<!--- save meeting code selections in a list --->
		<cfset ary_mcodes = #ListToarray(form.mcode)#>
		<!--- Update meeting status --->
		<cfloop from="1" to="#ArrayLen(ary_mcodes)#" index="x">
		<CFQUERY DATASOURCE="#application.rosterDSN#"  NAME="q2">
			UPDATE roster set closed = #form.status# where meetingcode = '#ary_mcodes[x]#'
		</CFQUERY>
		<!---<cfoutput>#ary_mcodes[x]#<br></cfoutput> --->
		</cfloop>
	<cfelse>
		<!--- post error message --->
	</cfif>
	<FORM NAME="step3" ACTION="" METHOD="post">
	<cfset sStatus = "">
	<cfif #form.status# EQ 0>
		<cfset sStatus = "Closed">
	<cfelse>
		<cfset sStatus = "Cancelled">
	</cfif>
	<cfoutput>
	<table>
	<tr>
		<td width=50>&nbsp;</td>
		<TD colspan=2><h4><font color="green">Processing Complete!</font></h4></TD>
	</tr>
	<tr>
		<td width=50>&nbsp;</td>
		<TD colspan=2><b>#ArrayLen(ary_mcodes)# meetings were set to status <u>#sStatus#</u></b></TD>
	</tr>
	<tr height=20><td colspan=3>&nbsp;</td></tr>
	<tr>
		<td width=50>&nbsp;</td>
		<TD ALIGN="center"><input TYPE="Button"  NAME="finish" VALUE="Finished" onClick="action = 'roster_close_roster.cfm?a=1&#Rand()#'; submit();"></TD>
	</tr>
	<tr height=20><td colspan=3>&nbsp;</td></tr>
	</table>
	</cfoutput>
	</form>

</cfcase>

<!--- If no case is specified user is sent a processing error --->
<!---
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
		<TD ALIGN="right"><input TYPE="Button"  NAME="tryagain" VALUE="Try Again" onClick="action = 'roster_recruit_roster.cfm'; submit();"></TD>
		<td>&nbsp;</td>
	</tr>
	<tr height=50><td colspan=3>&nbsp;</td></tr>
	</table>
	</form>
</CFDEFAULTCASE>
--->
</CFSWITCH>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">

