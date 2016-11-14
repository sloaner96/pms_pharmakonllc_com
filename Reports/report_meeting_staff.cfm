<!----------------------
report_meeting_staff.cfm


------------------------->
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Program Staff Report" showCalendar="0">

<script language="JavaScript">

function OpenHTMLReport()
{
	if (document.submitpage.projcode.value == 0)
	{
		alert("Please select a project.")
		return false;
	}
	else
	{
		document.submitpage.action = "report_meeting_staff2.cfm?report=HTML";
		document.submitpage.submit();
	}
	
}

function OpenExcelReport()
{
	if (document.submitpage.projcode.value == 0)
	{
		alert("Please select a project.")
		return false;
	}
	else
	{
		document.submitpage.action = "report_meeting_staff2.cfm?report=Excel&no_menu=1";
		document.submitpage.submit();
	}
}
</script>



<CFQUERY DATASOURCE="#application.projdsn#" NAME="getProjectCode">
	SELECT DISTINCT project_code
	FROM schedule_meeting_time
	ORDER BY project_code
</CFQUERY>

<form action="report_meeting_staff2.cfm" method="post" name="submitpage">		
	<TABLE ALIGN="Center" BORDER="0"CELLSPACING="0" CELLPADDING="0" >
		<TR>
			<TD height="50" valign="middle" ALIGN="Center" style="padding-top: 6px; padding-bottom: 6px;">
			<font color="#990000"><strong>Project: </strong></font>&nbsp;&nbsp;
			<select name="projcode">
				<option value="0">All Projects</option>
				<cfoutput query="getProjectCode">
					<option value="#getProjectCode.project_code#">#getProjectCode.project_code#</option>
				</cfoutput>
			</select>
			</TD>
		</TR>
		<!--- <TR>
			<TD ALIGN="Center" style="padding-top: 6px; padding-bottom: 6px;"><input type="radio" name="rType" value="All" checked>&nbsp;Show All &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="rType" value="Mod">&nbsp;Moderator Only &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="rType" value="Spkr">&nbsp;Speaker Only</TD>
		</TR> --->
		<TR>
			<TD ALIGN="Center" style="padding-top: 6px; padding-bottom: 6px;"><input type="button" value=" Generate HTML Report " onclick="OpenHTMLReport()"> &nbsp; &nbsp; &nbsp; &nbsp; <input type="button" value=" Generate EXCEL Report " onclick="OpenExcelReport()"></TD>
		</TR>
	</table>
</form>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">

