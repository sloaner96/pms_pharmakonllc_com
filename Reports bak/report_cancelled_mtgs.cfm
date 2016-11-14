<!----------------------
report_cancelled_mtgs.cfm


------------------------->
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Cancelled meetings Report" showCalendar="1">


<script language="JavaScript">
function CheckDates(oForm)
{
	var Bdate = oForm.begin_date.value;
	var Edate = oForm.end_date.value
	var B_ASCIICode = Bdate.charCodeAt();
	var E_ASCIICode = Edate.charCodeAt();
	
	if(Bdate == "" || B_ASCIICode == 32)
	{
		alert("Please enter a begining date.");
		return false;
	}
	else if(Edate == "" || E_ASCIICode == 32)
	{
		alert("Please enter an ending date.");
		return false;
	}
	else
	{
		return true;
	}
}

function OpenHTMLReport()
{
	if(document.forms[0].begin_date.value == "" || document.forms[0].end_date.value == "")
	{
		alert("All Fields are Required")
		return false;
	}
	else
	{
		document.forms[0].action = "report_cancelled_mtgs2.cfm?report=HTML";
		document.forms[0].submit();
	}
	
}

function OpenExcelReport()
{
	if(document.forms[0].begin_date.value == "" || document.forms[0].end_date.value == "")
	{
		alert("All Fields are Required")
		return false;
	}
	else
	{
		document.forms[0].action = "report_cancelled_mtgs2.cfm?report=Excel&no_menu=1";
		document.forms[0].submit();
	}
}
</script>
<SCRIPT SRC="/includes/libraries/CallCal.js"></SCRIPT>
</head>

<body>

<cfset beginingdate = #DateAdd("d", -7, Now())#>
<cfset endingdate = Now()>

<CFQUERY DATASOURCE="#application.projdsn#" NAME="getProjectCode">
	SELECT DISTINCT project_code
	FROM schedule_meeting_time
	ORDER BY project_code
</CFQUERY>

<form action="report_listen_ins2.cfm" method="post" onsubmit="return CheckDates(this)">		
	<TABLE ALIGN="Center" BORDER="0" WIDTH="600px" CELLSPACING="0" CELLPADDING="0">
		<TR>
			<TD ALIGN="Center" style="padding-top: 6px; padding-bottom: 6px;">
			<B>Begin Date:</B>&nbsp;&nbsp;&nbsp;&nbsp;
						<cfmodule template="#Application.tagpath#/ctags/calInput.cfm"
						          inputname="begin_date"
								  htmlID="begindate"
								  FormValue="#DateFormat(beginingdate, 'mm/dd/yyyy')#"
								  imgid="begindatebtn">
						 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<B>End Date:</B>&nbsp;&nbsp;&nbsp;&nbsp;
						<cfmodule template="#Application.tagpath#/ctags/calInput.cfm"
						          inputname="end_date"
								  htmlID="enddate"
								  FormValue="#DateFormat(endingdate, 'mm/dd/yyyy')#"
								  imgid="enddatebtn"></td>
		</TR>
		<TR>
			<TD ALIGN="Center" style="padding-top: 6px; padding-bottom: 6px;">
			<font color="#990000"><strong>Project: </strong></font>&nbsp;&nbsp;
			<select name="projcode">
				<option value="0">All Projects</option>
				<cfoutput query="getProjectCode">
					<option value="#getProjectCode.project_code#">#getProjectCode.project_code#</option>
				</cfoutput>
			</select>
			</TD>
		</TR>
		<TR>
			<TD ALIGN="Center" style="padding-top: 6px; padding-bottom: 6px;"><input type="button"  value=" Generate HTML Report " onclick="OpenHTMLReport()"> &nbsp; &nbsp; &nbsp; &nbsp; <input type="button"  value=" Generate EXCEL Report " onclick="OpenExcelReport()"></TD>
		</TR>
	</table>
</form>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">

