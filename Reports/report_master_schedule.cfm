<!----------------------------------------------
report_maser_schedule.cfm

Choose dates to display master schedule.
------------------------------------------------>
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Moderator Master Schedule" showCalendar="1">

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
</script>

<cfset beginingdate = Now()>
<cfset endingdate = #DateAdd("d", 7, Now())#>
<FORM METHOD="post" action="report_master_schedule3.cfm" onsubmit="return CheckDates(this)">
<TABLE ALIGN="Center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="100%">
	<TR> 
		<TD>	<!--- Table containing input fields --->
			<TABLE ALIGN="Center" BORDER="0" WIDTH="99%" CELLSPACING="1" CELLPADDING="10">
				<TR>
					<TD ALIGN="Center">
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
								  imgid="enddatebtn"></TD>
				</TR>
				<TR>
					<TD ALIGN="center">
						<INPUT TYPE="submit"  VALUE=" Generate Report in EXCEL ">
					</TD>
				</TR>
			</TABLE>
		</TD>
	</TR>
</TABLE>
</FORM>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
