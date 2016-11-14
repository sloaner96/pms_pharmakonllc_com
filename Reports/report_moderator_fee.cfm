<!----------------------------
report_moderator_fee.cfm

Merge letter that allows moderator fee report to be generated and exported to MS Word.

--------------------------------->
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Moderator Fee Statement Report" showCalendar="1">

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


<CFQUERY DATASOURCE="#application.SpeakerDSN#" NAME='getModerator'>
	SELECT speakerid, lastname, firstname
	FROM Speaker
	WHERE active = 'yes' 
	AND type = 'MOD' 
	ORDER BY lastname
</CFQUERY>

<cfset beginingdate = #DateAdd("d", -7, Now())#>
<cfset endingdate = Now()>

<form action="report_moderator_fee2.cfm?no_menu=1" method="post" onsubmit="return CheckDates(this)">		
	<TABLE ALIGN="Center" BORDER="0" CELLSPACING="0" CELLPADDING="0">

		<TR>
			<TD ALIGN="Center" style="padding-top: 4px; padding-bottom: 4px;">
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
		</tr>
		<TR>
			<TD ALIGN="Center" style="padding-top: 4px; padding-bottom: 4px;">
			<font color="##990000"><strong>Select A Moderator:</strong></font>&nbsp;&nbsp;
			<select name="moderator">
				<cfoutput query="getModerator">
					<option value="#getModerator.speakerid#">#trim(getModerator.firstname)# #trim(getModerator.lastname)#</option>
				</cfoutput>
			</select>
			</td>
		</tr>
		<TR>
			<TD ALIGN="Center" style="padding-top: 4px; padding-bottom: 4px;"><input type="submit"  value=" Generate Report "></TD>
		</TR>
	</table>
</form>
</body>
</html>

