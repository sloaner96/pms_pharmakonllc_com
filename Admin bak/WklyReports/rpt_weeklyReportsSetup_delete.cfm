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
<body id="main">
<h1>Setup Information for <cfoutput>#session.project_code#</cfoutput> has been deleted!</h1>
</body>
</html>


