<CFQUERY DATASOURCE="#application.WeeklyRptDSN#" NAME="qDelete1">
	delete from Weekly_Reports_Decile_Information
	where projectcode = '#session.project_code#'
</CFQUERY>
<CFQUERY DATASOURCE="#application.WeeklyRptDSN#" NAME="qDelete2">
	delete from Weekly_Reports_Poll
	where projectcode = '#session.project_code#'
</CFQUERY>
<CFQUERY DATASOURCE="#application.WeeklyRptDSN#" NAME="qDelete3">
	delete from Weekly_Reports_Program_Information
	where projectcode = '#session.project_code#'
</CFQUERY>
<CFQUERY DATASOURCE="#application.WeeklyRptDSN#" NAME="qDelete4">
	delete from Weekly_Reports_Query_Exists
	where projectcode = '#session.project_code#'
</CFQUERY>
<CFQUERY DATASOURCE="#application.WeeklyRptDSN#" NAME="qDelete5">
	delete from Weekly_Reports_Query_Labels
	where projectcode = '#session.project_code#'
</CFQUERY>

<html>
<heaD>
<title>Delete Weekly Reports</title>
<link href="simple.css" rel="stylesheet" type="text/css">
</head>
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Weekly Reports Setup: ADD" showCalendar="0">
<body id="main">
<h4>Setup Information for <cfoutput>#session.project_code#</cfoutput> has been deleted!</h4>
<br><br>
<table cellpadding="2" cellspacing="2">
<tr height="10"><td colspan="3"></td></tr>
	<tr>
		<td width="100"></td>		
		<td colspan="2">
			<FORM>
				<INPUT type="button" value=" Weekly Report Setup " onClick="location.href='rpt_weeklyReportsSetup.cfm'">
			</FORM>
		</td>
	</tr>
</table>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
</body>
</html>


