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

</head>
<CFSWITCH EXPRESSION="#URL.a#">
<!--- Step #1 --->
<CFCASE VALUE="1">
	<!--- Pull appropriate row for the selected project code --->
	<CFQUERY DATASOURCE="#application.rosterDSN#"  NAME="q1">
			select distinct(meetingcode) --selects distinct meetingcodes based on date
			from roster
			where
			meetingcode is not null
			and apptdate  between '#form.begin_date#' and '#form.end_date#'
			and meetingcode in
			(
			select distinct(meetingcode)
			from roster
			where
			meetingcode is not null
			and apptdate  between '#form.begin_date#' and '#form.end_date#'
			and terr1_id is null
			)
	</CFQUERY>
	<body>

<table style="font-size:12pt;">
	<tr height=50><td width=50>&nbsp;</td><td style="left:25;">

	<b>Meetingcodes without Reps for dates: <Cfoutput>#form.begin_date# - #form.end_date#</cfoutput></b>
	<cfset prevStr = "a">
	<cfset currStr = "b">
	<br>
	<cfloop query="q1">
	<cfoutput>
	<cfset currStr = #meetingcode#>
	<cfset currStr = #currStr.substring(0,9)#>
	<cfif currStr NEQ prevStr><br><b><i>#currStr#</i> -

	<CFQUERY DATASOURCE="#application.projdsn#" NAME="qproj">
			SELECT c.description
			FROM client_proj c, piw p
			WHERE c.client_proj = '#currStr#' AND c.client_proj = p.project_code
	</CFQUERY>

	<cfoutput>#qproj.description#</cfoutput>

	</b><br></cfif>
&nbsp;&nbsp;&nbsp;&nbsp; #meetingcode#<br>
	  <cfset prevStr = currStr>
	  </cfoutput>
	</cfloop>
	</td><td>&nbsp;</td></tr>
	<FORM NAME="" ACTION="" METHOD="post">
	<tr>
		<td width=50>&nbsp;</td>
		<TD ALIGN="right"><input TYPE="Button" NAME="Home" VALUE="Home" onClick="action = '/inbox.cfm'; submit();"></TD>
		<td>&nbsp;</td>
	</tr>
	<tr height=50><td colspan=3>&nbsp;</td></tr>
	</table>
	</form>
	</body>
</CFCASE>


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
		<TD ALIGN="right"><input TYPE="Button" NAME="tryagain" VALUE="Try Again" onClick="action = 'rep_update_exception.cfm'; submit();"></TD>
		<td>&nbsp;</td>
	</tr>
	<tr height=50><td colspan=3>&nbsp;</td></tr>
	</table>
	</form>
</CFDEFAULTCASE>
</CFSWITCH>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">

